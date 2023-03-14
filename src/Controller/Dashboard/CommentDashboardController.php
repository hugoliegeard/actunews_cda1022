<?php

namespace App\Controller\Dashboard;

use App\Entity\Comment;
use App\Repository\CommentRepository;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;

#[Route('/dashboard/comments')]
class CommentDashboardController extends AbstractController
{
    #[Route('/', name: 'comment_comments', methods: 'GET')]
    public function comments(CommentRepository $commentRepository): Response
    {
        # Récupération dans la BDD des categories
        $comments = $commentRepository->findAll();

        return $this->render('dashboard/comment/comments.html.twig', [
            'comments' => $comments
        ]);
    }

    #[Route('/{id}/delete', name: 'comment_delete', methods: 'GET')]
    public function deletePost(CommentRepository $commentRepository, Comment $comment = null): Response
    {
        if ($comment === null) {
            $this->addFlash('success', "Ce commentaire n'existe pas.");
            return $this->redirectToRoute('comment_comments');
        }

        $commentRepository->remove($comment, true);
        $this->addFlash('success', "Le commentaire '{$comment->getContent()}' a bien été supprimé.");
        return $this->redirectToRoute('comment_comments');
    }

}
