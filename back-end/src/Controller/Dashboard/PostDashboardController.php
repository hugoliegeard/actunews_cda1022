<?php

namespace App\Controller\Dashboard;

use App\Entity\Post;
use App\Form\PostType;
use App\Repository\PostRepository;
use Doctrine\Persistence\ManagerRegistry;
use Symfony\Component\HttpFoundation\File\File;
use Symfony\Component\HttpFoundation\File\UploadedFile;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;

#[Route('/dashboard/posts')]
class PostDashboardController extends AbstractController
{
    #[Route('/', name: 'post_posts', methods: 'GET')]
    public function posts(PostRepository $postRepository): Response
    {
        # Récupération dans la BDD des articles
        $posts = $postRepository->findAll();

        return $this->render('dashboard/post/posts.html.twig', [
            'posts' => $posts
        ]);
    }

    #[Route('/add', name: 'post_add', methods: 'GET|POST')]
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
            return $this->redirectToRoute('post_posts');

        }

        # Passage du formulaire à la vue
        return $this->render('dashboard/post/addpost.html.twig', [
            'form' => $form,
        ]);
    }

    #[Route('/{id}/edit', name: 'post_edit', methods: 'GET|POST')]
    public function editPost(Request $request, ManagerRegistry $doctrine, Post $post = null): Response
    {

        # Vérification des données
        if ($post === null) {
            $this->addFlash('success', "
                Cette article n'existe pas.
            ");
            return $this->redirectToRoute('post_posts');
        }

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
                Merci, votre article '{$post->getTitle()}' a bien été modifié.
            ");

            # Redirection sur une autre page
            return $this->redirectToRoute('post_posts');

        }

        # Passage du formulaire à la vue
        return $this->render('dashboard/post/addpost.html.twig', [
            'form' => $form,
        ]);
    }

    #[Route('/{id}/delete', name: 'post_delete', methods: 'GET')]
    public function deletePost(PostRepository $postRepository, Post $post = null): Response
    {
        if ($post === null) {
            $this->addFlash('success', "Cette article n'existe pas.");
            return $this->redirectToRoute('post_posts');
        }

        $postRepository->remove($post, true);
        $this->addFlash('success', "Votre article '{$post->getTitle()}' a bien été supprimé.");
        return $this->redirectToRoute('post_posts');
    }

}
