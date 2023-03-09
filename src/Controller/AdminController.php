<?php

namespace App\Controller;

use App\Entity\Category;
use App\Entity\Post;
use App\Form\CategoryType;
use App\Form\PostType;
use App\Repository\PostRepository;
use Doctrine\Persistence\ManagerRegistry;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
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

    #[Route('/category/add', name: 'category_add')]
    public function addCategory(Request $request, ManagerRegistry $doctrine): Response
    {
        $category = new Category();
        $form = $this->createForm(CategoryType::class, $category);

        $form->handleRequest($request);
        if ($form->isSubmitted() && $form->isValid()) {
            $em = $doctrine->getManager();
            $em->persist($category);
            $em->flush();
            return $this->redirectToRoute('home');
        }

        return $this->render('admin/index.html.twig', [
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
}
