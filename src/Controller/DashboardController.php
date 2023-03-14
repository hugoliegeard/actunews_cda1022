<?php

namespace App\Controller;

use App\Entity\Category;
use App\Entity\Comment;
use App\Entity\Post;
use App\Entity\User;
use Doctrine\Persistence\ManagerRegistry;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;

#[Route('/dashboard')]
class DashboardController extends AbstractController
{
    #[Route('/', name: 'dashboard_home', methods: 'GET')]
    public function home(ManagerRegistry $em): Response
    {
        # Récupération des données
        $total['users'] = $em->getRepository(User::class)->findTotal();
        $total['comments'] = $em->getRepository(Comment::class)->findTotal();
        $total['categories'] = $em->getRepository(Category::class)->findTotal();
        $total['posts'] = $em->getRepository(Post::class)->findTotal();
        $posts = $em->getRepository(Post::class)->findBy([], ['id' => 'DESC'], 10);

        # Transfert des données à la vue
        return $this->render('dashboard/dashboard.html.twig', [
            'total' => $total,
            'posts' => $posts
        ]);
    }

}
