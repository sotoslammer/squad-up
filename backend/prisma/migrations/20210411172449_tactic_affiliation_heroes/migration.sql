-- AlterTable
ALTER TABLE "Tactic" ADD COLUMN     "affiliationId" INTEGER;

-- CreateTable
CREATE TABLE "_SuperheroToTactic" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "_SuperheroToTactic_AB_unique" ON "_SuperheroToTactic"("A", "B");

-- CreateIndex
CREATE INDEX "_SuperheroToTactic_B_index" ON "_SuperheroToTactic"("B");

-- AddForeignKey
ALTER TABLE "_SuperheroToTactic" ADD FOREIGN KEY ("A") REFERENCES "Superhero"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_SuperheroToTactic" ADD FOREIGN KEY ("B") REFERENCES "Tactic"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Tactic" ADD FOREIGN KEY ("affiliationId") REFERENCES "Affiliation"("id") ON DELETE SET NULL ON UPDATE CASCADE;
