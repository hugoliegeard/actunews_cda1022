<?php

namespace App\Entity\Traits;

use Symfony\Component\Serializer\Annotation\Groups;
use Symfony\Component\Serializer\Annotation\SerializedName;

trait TimestampableEntityTrait
{
    #[SerializedName('createdAt')]
    #[Groups(['post:read'])]
    public function getCreatedAtTimestampable(): ?\DateTimeInterface
    {
        return $this->createdAt;
    }

    #[SerializedName('updatedAt')]
    #[Groups(['post:read'])]
    public function getUpdatedAtTimestampable(): ?\DateTimeInterface
    {
        return $this->updatedAt;
    }

    #[SerializedName('deleted')]
    #[Groups(['post:read'])]
    public function getDeletedAtTimestampable(): ?bool
    {
        return $this->deletedAt !== null;
    }
}