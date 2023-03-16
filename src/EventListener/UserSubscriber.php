<?php

namespace App\EventListener;

use App\Entity\User;
use Doctrine\Bundle\DoctrineBundle\EventSubscriber\EventSubscriberInterface;
use Doctrine\ORM\Events;
use Doctrine\Persistence\Event\LifecycleEventArgs;
use Symfony\Component\PasswordHasher\Hasher\UserPasswordHasherInterface;

class UserSubscriber implements EventSubscriberInterface
{

    private UserPasswordHasherInterface $passwordHasher;

    public function __construct(UserPasswordHasherInterface $passwordHasher)
    {
        $this->passwordHasher = $passwordHasher;
    }

    public function getSubscribedEvents(): array
    {
        return [
            Events::prePersist
        ];
    }

    public function prePersist(LifecycleEventArgs $args): void
    {
        # Récupération de l'objet qui va être inséré
        /** @var User $entity */
        $entity = $args->getObject();

        # Vérification qu'il s'agit bien d'un user
        if (!$entity instanceof User) {
            # Sinon, on arrête le script.
            return;
        }

        # Encodage du mot de passe
        $entity->setPassword(
            $this->passwordHasher->hashPassword(
                $entity,
                $entity->getPassword()
            )
        );

    }
}