<?php

namespace App\Controller;

use App\Entity\Category;
use App\Entity\Comment;
use App\Entity\Post;
use App\Entity\User;
use App\Repository\CategoryRepository;
use App\Repository\CommentRepository;
use App\Repository\PostRepository;
use App\Repository\UserRepository;
use Doctrine\Persistence\ManagerRegistry;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;

#[Route('/dashboard')]
class DashboardController extends AbstractController
{
    #[Route('/', name: 'dashboard_home', methods: 'GET')]
    public function home(UserRepository $userRepository,
                         CommentRepository $commentRepository,
                         PostRepository $postRepository,
                         CategoryRepository $categoryRepository): Response
    {
        # Récupération des données
        $total['users'] = $userRepository->findTotal();
        $total['comments'] = $commentRepository->findTotal();
        $total['categories'] = $categoryRepository->findTotal();
        $total['posts'] = $postRepository->findTotal();
        $posts = $postRepository->findBy([], ['id' => 'DESC'], 10);

        # Transfert des données à la vue
        return $this->render('dashboard/dashboard.html.twig', [
            'total' => $total,
            'posts' => $posts
        ]);
    }

}
