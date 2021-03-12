-- CreateEnum
CREATE TYPE "CrisisType" AS ENUM ('EXTRACT', 'SECURE');

-- CreateEnum
CREATE TYPE "Map" AS ENUM ('A', 'B', 'C', 'D', 'E', 'F');

-- CreateEnum
CREATE TYPE "TacticType" AS ENUM ('ACTIVE', 'REACTIVE');

-- CreateTable
CREATE TABLE "Affiliation" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,

    PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Crisis" (
    "id" SERIAL NOT NULL,
    "type" "CrisisType" NOT NULL,
    "threat" INTEGER NOT NULL,
    "name" TEXT NOT NULL,
    "map" "Map" NOT NULL,
    "setup" TEXT NOT NULL,
    "scoring" TEXT NOT NULL,
    "rules" TEXT[],

    PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Tactic" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "type" "TacticType" NOT NULL,
    "description" TEXT NOT NULL,

    PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_AffiliationToSuperhero" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "_AffiliationToSuperhero_AB_unique" ON "_AffiliationToSuperhero"("A", "B");

-- CreateIndex
CREATE INDEX "_AffiliationToSuperhero_B_index" ON "_AffiliationToSuperhero"("B");

-- AddForeignKey
ALTER TABLE "_AffiliationToSuperhero" ADD FOREIGN KEY ("A") REFERENCES "Affiliation"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_AffiliationToSuperhero" ADD FOREIGN KEY ("B") REFERENCES "Superhero"("id") ON DELETE CASCADE ON UPDATE CASCADE;
