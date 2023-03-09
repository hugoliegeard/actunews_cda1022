<?php

namespace App\Form;

use App\Entity\Category;
use App\Entity\Post;
use App\Entity\User;
use FOS\CKEditorBundle\Form\Type\CKEditorType;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\CheckboxType;
use Symfony\Component\Form\Extension\Core\Type\SubmitType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Vich\UploaderBundle\Form\Type\VichImageType;

class PostType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder
            ->add('title', TextType::class, [
                'label' => 'Titre de l\'article',
                'attr' => [
                    'placeholder' => 'Saisissez le titre de votre article'
                ]
            ])
            ->add('category', EntityType::class, [
                'label' => 'Catégorie',
                'class' => Category::class,
                'choice_label' => 'name'
            ])
            ->add('author', EntityType::class, [
                'label' => 'Auteur.trice',
                'class' => User::class,
                'choice_label' => 'fullname'
            ])
            ->add('content', CKEditorType::class, [
                'label' => 'Contenu de l\'article'
            ])
            ->add('imageFile', VichImageType::class)
            ->add('active', CheckboxType::class, [
                'label' => 'Publier l\'article ?',
                'required' => false
            ])
            ->add('submit', SubmitType::class, [
                'label' => 'Sauvegarder et publier mon article'
            ])
        ;

    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Post::class,
        ]);
    }

}