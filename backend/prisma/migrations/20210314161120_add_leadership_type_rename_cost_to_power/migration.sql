/*
  Warnings:

  - You are about to drop the column `cost` on the `SuperPower` table. All the data in the column will be lost.

*/
-- AlterEnum
ALTER TYPE "SuperPowerType" ADD VALUE 'LEADERSHIP';

-- AlterTable
ALTER TABLE "SuperPower" DROP COLUMN "cost",
ADD COLUMN     "power" TEXT;
