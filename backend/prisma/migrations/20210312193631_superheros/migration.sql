-- CreateEnum
CREATE TYPE "AttackType" AS ENUM ('PHYSICAL', 'ENERGY', 'MYSTIC');

-- CreateEnum
CREATE TYPE "SuperPowerType" AS ENUM ('ACTIVE', 'REACTIVE', 'INNATE');

-- CreateTable
CREATE TABLE "Superhero" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "alterEgo" TEXT NOT NULL,
    "stamina" INTEGER NOT NULL,
    "speed" INTEGER NOT NULL,
    "size" INTEGER NOT NULL,
    "threat" INTEGER NOT NULL,
    "physicalD" INTEGER NOT NULL,
    "energyD" INTEGER NOT NULL,
    "mysticD" INTEGER NOT NULL,

    PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Attack" (
    "id" SERIAL NOT NULL,
    "superheroId" INTEGER NOT NULL,
    "name" TEXT NOT NULL,
    "type" "AttackType" NOT NULL,
    "range" TEXT NOT NULL,
    "strength" TEXT NOT NULL,
    "power" INTEGER NOT NULL DEFAULT 0,

    PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SuperPower" (
    "id" SERIAL NOT NULL,
    "superheroId" INTEGER NOT NULL,
    "name" TEXT NOT NULL,
    "cost" INTEGER NOT NULL,
    "type" "SuperPowerType" NOT NULL,
    "description" TEXT NOT NULL,

    PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "Attack" ADD FOREIGN KEY ("superheroId") REFERENCES "Superhero"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SuperPower" ADD FOREIGN KEY ("superheroId") REFERENCES "Superhero"("id") ON DELETE CASCADE ON UPDATE CASCADE;
