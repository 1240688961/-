sed -i 's/\r//' POSCAR
select=` awk 'NR==8{print $1}' POSCAR`

if [[ "$select" != S* ]]
then
	head -n 8 POSCAR > 1poscar
	cat /dev/null > atom_cart2
	head -n 8 POSCAR > 2poscar
	tail -n +9 POSCAR > caterisn

	num_atom=`  sed -n 7p POSCAR | awk -F" " '{print NF;if(NR>0)exit}' `
	for((i=1;i<=$num_atom;i++))
	do
		atom1=` awk 'NR==7{print $'$i'}' POSCAR`
		echo $atom1
		head -n +$atom1 caterisn > atom_cart1
		for((j=1;j<=$atom1;j++))
		do
			lines=` awk '{print NR}' atom_cart1 |tail -n1 `
			min=100
			for((k=1;k<=$lines;k++))
			do
				coordinate_z=` sed -n ${k}p atom_cart1 |awk '{print $3}'`
				judgment_min=` echo "$coordinate_z<$min" |bc `
				if [ "$judgment_min" == "1" ]
				then
					min=$coordinate_z
					line_min=$k
				fi
			done
			sed -n ${line_min}p atom_cart1 >> atom_cart2
			sed -i ${line_min}d atom_cart1
		done
		atom1_half=` expr $atom1 / 2`
		head -n $atom1_half atom_cart2 >> 1poscar
		tail -n $atom1_half atom_cart2 >> 2poscar
		sed -i 1,${atom1}d caterisn
		cat /dev/null > atom_cart2
		sed -i "7s/$atom1/\ /" 1poscar
		sed -i "7s/$/\ \ $atom1_half/g" 1poscar
		sed -i "7s/$atom1/\ /" 2poscar
		sed -i "7s/$/\ \ $atom1_half/g" 2poscar
	done

else
	head -n 9 POSCAR > 1poscar
	cat /dev/null > atom_cart2
	head -n 9 POSCAR > 2poscar
	tail -n +10 POSCAR > caterisn

	num_atom=`  sed -n 7p POSCAR | awk -F" " '{print NF;if(NR>0)exit}' `
	for((i=1;i<=$num_atom;i++))
	do
		atom1=` awk 'NR==7{print $'$i'}' POSCAR`
		echo $atom1
		head -n +$atom1 caterisn > atom_cart1
		for((j=1;j<=$atom1;j++))
		do
			lines=` awk '{print NR}' atom_cart1 |tail -n1 `
			min=100
			for((k=1;k<=$lines;k++))
			do
				coordinate_z=` sed -n ${k}p atom_cart1 |awk '{print $3}'`
				judgment_min=` echo "$coordinate_z<$min" |bc `
				if [ "$judgment_min" == "1" ]
				then
					min=$coordinate_z
					line_min=$k
				fi
			done
			sed -n ${line_min}p atom_cart1 >> atom_cart2
			sed -i ${line_min}d atom_cart1
		done
		atom1_half=` expr $atom1 / 2`
		head -n $atom1_half atom_cart2 >> 1poscar
		tail -n $atom1_half atom_cart2 >> 2poscar
		sed -i 1,${atom1}d caterisn
		cat /dev/null > atom_cart2
		sed -i "7s/$atom1/\ /" 1poscar
		sed -i "7s/$/\ \ $atom1_half/g" 1poscar
		sed -i "7s/$atom1/\ /" 2poscar
		sed -i "7s/$/\ \ $atom1_half/g" 2poscar
	done
fi

rm atom_cart1 atom_cart2  caterisn
