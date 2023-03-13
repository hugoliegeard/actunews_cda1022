<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;

class DefaultController extends AbstractController
{
    /**
     * Page d'accueil
     */
    public function home()
    {
        return $this->redirectToRoute('admin_dashboard');
    }

    public function contact()
    {
        return $this->render('default/contact.html.twig');
    }

}