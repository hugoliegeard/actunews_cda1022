<?php

namespace App\Controller\Dashboard;

use App\Entity\Category;
use App\Form\CategoryType;
use App\Repository\CategoryRepository;
use Doctrine\Persistence\ManagerRegistry;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;

#[Route('/dashboard/categories')]
class CategoryDashboardController extends AbstractController
{
    #[Route('/', name: 'category_categories', methods: 'GET')]
    public function categories(CategoryRepository $categoryRepository): Response
    {
        # Récupération dans la BDD des categories
        $categories = $categoryRepository->findAll();

        return $this->render('dashboard/category/categories.html.twig', [
            'categories' => $categories
        ]);
    }

    #[Route('/add', name: 'category_add')]
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
            return $this->redirectToRoute('category_categories');
        }

        return $this->render('dashboard/category/addcategory.html.twig', [
            'form' => $form->createView(),
        ]);
    }

    #[Route('/{id}/edit', name: 'category_edit')]
    public function editCategory(Request $request, ManagerRegistry $doctrine, Category $category = null): Response
    {
        if ($category === null) {
            $this->addFlash('success', "Cette article n'existe pas.");
            return $this->redirectToRoute('post_posts');
        }

        $form = $this->createForm(CategoryType::class, $category);

        $form->handleRequest($request);
        if ($form->isSubmitted() && $form->isValid()) {

            # Sauvegarde dans la BDD
            $em = $doctrine->getManager();
            $em->persist($category);
            $em->flush();

            # Notification Flash à l'utilisateur
            $this->addFlash('success', "
                Merci, votre catégorie '{$category->getName()}' a bien été modifiée.
            ");

            # Redirection sur une autre page
            return $this->redirectToRoute('category_categories');
        }

        return $this->render('dashboard/category/addcategory.html.twig', [
            'form' => $form->createView(),
        ]);
    }

    #[Route('/{id}/delete', name: 'category_delete', methods: 'GET')]
    public function deletePost(CategoryRepository $categoryRepository, Category $category = null): Response
    {
        if ($category === null) {
            $this->addFlash('success', "Cette catégorie n'existe pas.");
            return $this->redirectToRoute('category_categories');
        }

        $categoryRepository->remove($category, true);
        $this->addFlash('success', "Votre catégorie '{$category->getName()}' a bien été supprimée.");
        return $this->redirectToRoute('category_categories');
    }

}
