<?php

namespace App\Controller;

use App\Entity\Category;
use App\Entity\Post;
use App\Entity\User;
use App\Form\CategoryType;
use App\Form\PostType;
use App\Form\UserType;
use App\Repository\CategoryRepository;
use App\Repository\CommentRepository;
use App\Repository\PostRepository;
use App\Repository\UserRepository;
use Doctrine\Persistence\ManagerRegistry;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\PasswordHasher\Hasher\UserPasswordHasherInterface;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;

#[Route('/dashboard')]
class AdminController extends AbstractController
{

    #[Route('/', name: 'admin_dashboard', methods: 'GET')]
    public function dashboard()
    {
        return $this->render('admin/dashboard.html.twig');
    }

    #[Route('/categories', name: 'admin_categories', methods: 'GET')]
    public function categories(CategoryRepository $categoryRepository): Response
    {
        # Récupération dans la BDD des categories
        $categories = $categoryRepository->findAll();

        return $this->render('admin/categories.html.twig', [
            'categories' => $categories
        ]);
    }

    #[Route('/category/add', name: 'admin_addcategory')]
    public function addCategory(Request $request, ManagerRegistry $doctrine): Response
    {
        $category = new Category();
        $form = $this->createForm(CategoryType::class, $category);

        $form->handleRequest($request);
        if ($form->isSubmitted() && $form->isValid()) {

            # Sauvegarde dans la BDD
            $em = $doctrine->getManager();
            $em->persist($category);
            $em->flush();

            # Notification Flash à l'utilisateur
            $this->addFlash('success', "
                Merci, votre catégorie '{$category->getName()}' a bien été créée.
            ");

            # Redirection sur une autre page
            return $this->redirectToRoute('admin_categories');
        }

        return $this->render('admin/addcategory.html.twig', [
            'form' => $form->createView(),
        ]);
    }

    #[Route('/posts', name: 'admin_posts', methods: 'GET')]
    public function posts(PostRepository $postRepository): Response
    {
        # TODO : Utiliser a la place un système de pagination
        # Récupération dans la BDD des articles
        $posts = $postRepository->findAll();

        return $this->render('admin/posts.html.twig', [
            'posts' => $posts
        ]);
    }

    #[Route('/post/add', name: 'admin_addpost', methods: 'GET|POST')]
    public function addPost(Request $request, ManagerRegistry $doctrine): Response
    {
        # Création d'un nouvel article
        $post = new Post();

        # Création du formulaire
        $form = $this->createForm(PostType::class, $post);
        $form->handleRequest($request);

        # Vérification de notre formulaire
        if ($form->isSubmitted() && $form->isValid()) {

            # Sauvegarde dans la BDD
            $em = $doctrine->getManager();
            $em->persist($post);
            $em->flush();

            # Notification Flash à l'utilisateur
            $this->addFlash('success', "
                Merci, votre article '{$post->getTitle()}' a bien été publié.
            ");

            # Redirection sur une autre page
            return $this->redirectToRoute('admin_posts');

        }

        # Passage du formulaire à la vue
        return $this->render('admin/addpost.html.twig', [
            'form' => $form,
        ]);
    }

    #[Route('/users', name: 'admin_users', methods: 'GET')]
    public function users(UserRepository $userRepository): Response
    {
        # Récupération dans la BDD des categories
        $users = $userRepository->findAll();

        return $this->render('admin/users.html.twig', [
            'users' => $users
        ]);
    }

    #[Route('/comments', name: 'admin_comments', methods: 'GET')]
    public function comments(CommentRepository $commentRepository): Response
    {
        # Récupération dans la BDD des categories
        $comments = $commentRepository->findAll();

        return $this->render('admin/comments.html.twig', [
            'comments' => $comments
        ]);
    }

    #[Route('/user/add', name: 'admin_adduser', methods: 'GET|POST')]
    public function addUser(Request $request, ManagerRegistry $doctrine, UserPasswordHasherInterface $passwordHasher): Response
    {
        # Création d'un nouvel article
        $user = new User();
        $plainPassword = $user->getPassword();
        dump($plainPassword);

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
            return $this->redirectToRoute('admin_users');

        }

        # Passage du formulaire à la vue
        return $this->render('admin/adduser.html.twig', [
            'form' => $form,
        ]);
    }

}
