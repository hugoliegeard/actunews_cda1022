<?php

namespace App\Controller\Dashboard;

use App\Entity\User;
use App\Form\UserType;
use App\Repository\UserRepository;
use App\Service\Mailjet\Mailing\UserMailing;
use Doctrine\Persistence\ManagerRegistry;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\PasswordHasher\Hasher\UserPasswordHasherInterface;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Twig\Error\LoaderError;
use Twig\Error\RuntimeError;
use Twig\Error\SyntaxError;

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
    public function addUser(Request $request,
                            UserMailing $userMailing,
                            ManagerRegistry $doctrine): Response
    {
        # Création d'un nouvel article
        $user = new User();
        $user->setCreatedAt(new \DateTime()); #FIXME Doit se faire automatiquement
        $user->setUpdatedAt(new \DateTime()); #FIXME Doit se faire automatiquement
        $plainPassword = $user->getPassword();

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
                Merci, votre utilisateur '{$user->getFullname()}' a bien été créé.
            ");

            # Envoi d'un e-mail à l'utilisateur avec son mot de passe. (A réinitialiser lors de la première connexion)
            try {
                $userMailing->sendRegistrationMail($user, $plainPassword);
            } catch (LoaderError|RuntimeError|SyntaxError) {
                $this->addFlash('danger', "Une erreur est survenu lors de l'envoi de l'email.");
            }

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
