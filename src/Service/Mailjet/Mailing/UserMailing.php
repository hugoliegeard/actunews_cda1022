<?php

namespace App\Service\Mailjet\Mailing;

use App\Entity\User;
use App\Service\Mailjet\AbstractMailjet;
use Twig\Error\LoaderError;
use Twig\Error\RuntimeError;
use Twig\Error\SyntaxError;

class UserMailing extends AbstractMailjet
{
    /**
     * Envoi d'un email d'inscription à l'utilisateur
     * @param User $user
     * @param string $plainPassword
     * @return void
     * @throws LoaderError
     * @throws RuntimeError
     * @throws SyntaxError
     */
    public function sendRegistrationMail(User $user, string $plainPassword): void
    {
        # Génération du message de l'email
        $message = $this->templateRender('emails/models/user/registration.html.twig', [
           'user' => $user,
           'plainPassword' => $plainPassword
        ]);

        # Envoi de l'email à l'utilisateur
        $this->send($this->generateBody('ACTUNEWS : Ouverture de votre compte', $message, $user));
    }
}
