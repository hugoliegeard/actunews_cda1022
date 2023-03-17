<?php

namespace App\Controller\Api;

use App\Entity\User;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Bundle\SecurityBundle\Security;

class MeController extends AbstractController
{
    private Security $security;

    public function __construct(Security $security)
    {
        $this->security = $security;
    }

    public function __invoke(): User
    {
        /** @var User $user */
        $user = $this->security->getUser();
        $user->setPassword('');

        return $user;
    }
}
