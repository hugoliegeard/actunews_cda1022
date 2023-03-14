<?php

namespace App\Controller\Dashboard;

use App\Entity\User;
use App\Form\UserType;
use App\Repository\UserRepository;
use Doctrine\Persistence\ManagerRegistry;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\PasswordHasher\Hasher\UserPasswordHasherInterface;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;

#[Route('/dashboard/users')]
class UserDashboardController extends AbstractController
{
    #[Route('/', name: 'user_users', methods: 'GET')]
    public function users(UserRepository $userRepository): Response
    {
        # Récupération dans la BDD des categories
        $users = $userRepository->findAll();

        return $this->render('dashboard/user/users.html.twig', [
            'users' => $users
        ]);
    }

    #[Route('/add', name: 'user_add', methods: 'GET|POST')]
    public function addUser(Request $request, ManagerRegistry $doctrine, UserPasswordHasherInterface $passwordHasher): Response
    {
        # Création d'un nouvel article
        $user = new User();
        $plainPassword = $user->getPassword();

        # Création du formulaire
        $form = $this->createForm(UserType::class, $user);
        $form->handleRequest($request);

        # Vérification de notre formulaire
        if ($form->isSubmitted() && $form->isValid()) {

            # Encodage du mot de passe
            $user->setPassword(
                $passwordHasher->hashPassword(
                    $user,
                    $user->getPassword()
                )
            );

            # Sauvegarde dans la BDD
            $em = $doctrine->getManager();
            $em->persist($user);
            $em->flush();

            # Notification Flash à l'utilisateur
            $this->addFlash('success', "
                Merci, votre utilisateur '{$user->getFullname()}' a bien été créé.
            ");

            # TODO : Envoi d'un e-mail à l'utilisateur avec son mot de passe. LOL
            # FIXME : Idéalement il faudrait envoyer à l'utilisateur un e-mail avec un token de reset password.

            # Redirection sur une autre page
            return $this->redirectToRoute('user_users');

        }

        # Passage du formulaire à la vue
        return $this->render('dashboard/user/adduser.html.twig', [
            'form' => $form,
        ]);
    }

    #[Route('/{id}/edit', name: 'user_edit', methods: 'GET|POST')]
    public function editUser(Request $request, ManagerRegistry $doctrine, UserPasswordHasherInterface $passwordHasher, User $user): Response
    {
        # Création du formulaire
        $form = $this->createForm(UserType::class, $user);
        $form->handleRequest($request);

        # Vérification de notre formulaire
        if ($form->isSubmitted() && $form->isValid()) {

            # Sauvegarde dans la BDD
            $em = $doctrine->getManager();
            $em->persist($user);
            $em->flush();

            # Notification Flash à l'utilisateur
            $this->addFlash('success', "
                Merci, votre utilisateur '{$user->getFullname()}' a bien été modifiée.
            ");

            # TODO : Envoi d'un e-mail à l'utilisateur avec le contenu de la modification de son compte

            # Redirection sur une autre page
            return $this->redirectToRoute('user_users');

        }

        # Passage du formulaire à la vue
        return $this->render('dashboard/user/adduser.html.twig', [
            'form' => $form,
        ]);
    }

    #[Route('/{id}/delete', name: 'user_delete', methods: 'GET')]
    public function deletePost(UserRepository $userRepository, User $user = null): Response
    {
        if ($user === null) {
            $this->addFlash('success', "Cet utilisateur n'existe pas.");
            return $this->redirectToRoute('user_users');
        }

        $userRepository->remove($user, true);
        $this->addFlash('success', "Votre utilisateur '{$user->getFullname()}' a bien été supprimé.");
        return $this->redirectToRoute('user_users');
    }

}
