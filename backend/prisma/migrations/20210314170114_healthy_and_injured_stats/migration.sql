/*
  Warnings:

  - Added the required column `healthy` to the `Attack` table without a default value. This is not possible if the table is not empty.
  - Added the required column `injured` to the `Attack` table without a default value. This is not possible if the table is not empty.
  - Added the required column `healthy` to the `SuperPower` table without a default value. This is not possible if the table is not empty.
  - Added the required column `injured` to the `SuperPower` table without a default value. This is not possible if the table is not empty.
  - Added the required column `staminaInjured` to the `Superhero` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Attack" ADD COLUMN     "healthy" BOOLEAN NOT NULL,
ADD COLUMN     "injured" BOOLEAN NOT NULL;

-- AlterTable
ALTER TABLE "SuperPower" ADD COLUMN     "healthy" BOOLEAN NOT NULL,
ADD COLUMN     "injured" BOOLEAN NOT NULL;

-- AlterTable
ALTER TABLE "Superhero" ADD COLUMN     "staminaInjured" INTEGER NOT NULL;
