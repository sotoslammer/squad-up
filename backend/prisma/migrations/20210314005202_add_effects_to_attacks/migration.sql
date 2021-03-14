/*
  Warnings:

  - You are about to drop the column `description` on the `SuperPower` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "SuperPower" DROP COLUMN "description",
ADD COLUMN     "effects" TEXT[];
