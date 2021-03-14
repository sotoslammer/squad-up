/*
  Warnings:

  - You are about to drop the column `effects` on the `SuperPower` table. All the data in the column will be lost.
  - Added the required column `effect` to the `SuperPower` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Attack" ADD COLUMN     "effects" TEXT[];

-- AlterTable
ALTER TABLE "SuperPower" DROP COLUMN "effects",
ADD COLUMN     "effect" TEXT NOT NULL;
