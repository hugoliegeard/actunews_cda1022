<?php

namespace App\Service\Mailjet;

use App\Entity\User;
use Mailjet\Client;
use Mailjet\Resources;
use Twig\Environment;
use Twig\Error\LoaderError;
use Twig\Error\RuntimeError;
use Twig\Error\SyntaxError;

abstract class AbstractMailjet
{

    private string $mjApikeyPublic;
    private string $mjApikeyPrivate;
    private int $templateID;
    private Environment $environment;
    const SENDER_EMAIL = 'clients@biyn.media';
    const SENDER_NAME = 'Service Clients';

    public function __construct(Environment $environment,
                                string $mjApikeyPublic,
                                string $mjApikeyPrivate,
                                int $templateID)
    {
        $this->mjApikeyPublic = $mjApikeyPublic;
        $this->mjApikeyPrivate = $mjApikeyPrivate;
        $this->templateID = $templateID;
        $this->environment = $environment;
    }

    /**
     * Permet de générer le message à envoyer
     * à un utilisateur de la BDD.
     * @param string $subject
     * @param string $message
     * @param User $user
     * @return array[]
     */
    protected function generateBody(string $subject, string $message, User $user): array
    {
        return [
            'Messages' => [
                [
                    'From' => [
                        'Email' => self::SENDER_EMAIL,
                        'Name' => self::SENDER_NAME
                    ],
                    'To' => [
                        [
                            'Email' => $user->getEmail(),
                            'Name' => $user->getFullname()
                        ]
                    ],
                    'TemplateID' => (int) $this->templateID,
                    'TemplateLanguage' => true,
                    'Subject' => $subject,
                    'Variables' => [
                        'title' => $subject,
                        'content' => $message,
                    ]
                ]
            ]
        ];
    }

    protected function send(array $body): void
    {
        $mj = new Client($this->mjApikeyPublic, $this->mjApikeyPrivate,true,['version' => 'v3.1']);
        $mj->post(Resources::$Email, ['body' => $body]);
    }

    /**
     * Permet de faire le rendu de mon template email.
     * @param $name
     * @param array $context
     * @return string
     * @throws LoaderError
     * @throws RuntimeError
     * @throws SyntaxError
     */
    protected function templateRender($name, array $context = []): string
    {
        return $this->environment->render($name, $context);
    }

}