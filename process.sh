# copy necessary files
# cp ~/Munka/HydroCarpath/Hydrocarpath2025_Abstracts.docx .
# Download from onedrive above file!
cp ~/Munka/HydroCarpath/veablogo.jpg .
cp ~/Munka/HydroCarpath/ccbyncsa.pdf .
cp ~/Munka/HydroCarpath/kiado1.pdf .
cp ~/Munka/HydroCarpath/Hydrocarpath_Program25_final.pdf HydroCarpathProgramme.pdf
cp -r ~/Munka/HydroCarpath/Posters .
cp -r ~/Munka/HydroCarpath/ShortArt .
mkdir Raw
lowriter --headless --convert-to txt Hydrocarpath2025_Abstracts.docx --outdir ./Raw
cd Raw
sed -e 's/%/\\%/g' Hydrocarpath2025_Abstracts.txt |\
    sed -e 's/≈/\$\\approx\$/g' |\
    sed -e 's/~/\\textasciitilde /g' |\
    sed -e 's/km2/km\$\^2\$/g' |\
    sed -e 's/\([1-9]\) ,/\1,/g' |\
    sed -e 's/\([1-9]\), \([1-9]\)/\1,\2/g' |\
    sed -e 's/ $//g' |\
    sed -e 's/&/\\&/g' |\
    sed -e 's/_/\\_/g' > tmp.txt
mv tmp.txt Hydrocarpath2025_Abstracts.txt
head -226 Hydrocarpath2025_Abstracts.txt > orals.txt
tail +226 Hydrocarpath2025_Abstracts.txt > posters.txt
cd ..
mkdir EaText
cd EaText
csplit --prefix=O --suppress-matched ../Raw/orals.txt '/Article ID: [0-9]*/' '{*}'
rm O00
cd ..
rm eaabstract.tex;for i in `ls EaText/O*`; do perl ./abstarct_gen.pl < $i >> eaabstract.tex; done
sed -e "s/ex{Ámon/ex{Amon, Gergely@\\\\'Amon/" eaabstract.tex |\
sed -e "s/ex{Négyesi/ex{Negyesi, Klaudia@N\\\\'egyesi/" |\
sed -e 's/ex{Šraj/ex{Sraj, Mojca@\\v{S}raj/' |\
sed -e 's/ex{Štefunková/ex{Stefunkova, Zuzana@\\v{S}tefunková/' |\
sed -e 's/ex{Čubrilo/ex{Cubrilo, Dragoslava@\\v{C}ubrilo/' |\
sed -e "s/ex{Széles/ex{Szeles, Borbala@Sz\\\\'eles/" |\
sed -e "s/ex{Német/ex{Nemet, Zsolt@N\\\\'emet/" > tmp.tex
mv tmp.tex eaabstract.tex
mkdir PostText
cd PostText
csplit --prefix=P --suppress-matched ../Raw/posters.txt '/Article ID: [0-9]*/' '{*}'
cd ..
rm posabstract.tex;for i in `ls PostText/P*`; do perl ./abstarct_gen.pl < $i >> posabstract.tex; done
sed -e "s/ex{Ámon/ex{Amon, Gergely@\\\\'Amon/" posabstract.tex |\
sed -e "s/ex{Kökény/ex{Kokeny, Gergely@Koeek\\\\'eny/" |\
sed -e 's/@Koee/@K\\"o/' |\
sed -e "s/ex{Báder/ex{Bader, Laszlo@B\\\\'ader/" |\
sed -e "s/ex{Kálmán/ex{Kalman, Attila@K\\\\'alm\\\\'an/" |\
sed -e 's/ex{König/ex{Konig, Anna-Maria@K\\"onig/' |\
sed -e 's/ex{Pölz/ex{Polz, Anna@P\\"olz/' |\
sed -e 's/ex{Štefunková/ex{Stefunkova, Zuzana@\\v{S}tefunková/' |\
sed -e 's/ex{Šurda/ex{Surda, Peter@\\v{S}urda/' |\
sed -e "s/ex{Széles/ex{Szeles, Borbala@Sz\\\\'eles/" |\
sed -e 's/ex{Šraj/ex{Sraj, Mojca@\\v{S}raj/' > tmp.tex
mv tmp.tex posabstract.tex
