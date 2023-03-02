<?php

namespace App\Controller;

use App\Entity\Category;
use App\Entity\Post;
use App\Form\CategoryType;
use App\Form\PostType;
use Doctrine\Persistence\ManagerRegistry;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;

class AdminController extends AbstractController
{
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

    #[Route('/post/add', name: 'post_add')]
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

            # TODO Notification Flash à l'utilisateur
            # TODO Redirection sur une autre page

        }

        # Passage du formulaire à la vue
        return $this->render('admin/index.html.twig', [
            'form' => $form,
        ]);
    }
}
