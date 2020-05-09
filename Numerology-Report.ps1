# Numerology
# v000.001 - December 25th 2016 - skel, helper functions, etc
# v000.002 - December 26th 2016 - first working version
# v000.003 - December 27th 2016 - first complete version

# numerology logic and helper functions
function LookupLetterValue([string]$s)
{
	$s = $s.ToUpper();

	switch ($s)
	{
		"A" { return 1 }
		"B" { return 2 }
		"C" { return 3 }
		"D" { return 4 }
		"E" { return 5 }
		"F" { return 6 }
		"G" { return 7 }
		"H" { return 8 }
		"I" { return 9 }
		"J" { return 1 }
		"K" { return 2 }
		"L" { return 3 }
		"M" { return 4 }
		"N" { return 5 }
		"O" { return 6 }
		"P" { return 7 }
		"Q" { return 8 }
		"R" { return 9 }
		"S" { return 1 }
		"T" { return 2 }
		"U" { return 3 }
		"V" { return 4 }
		"W" { return 5 }
		"X" { return 6 }
		"Y" { return 7 }
		"Z" { return 8 }
		" " { return 0 }
		"'" { return 0 }
		"-" { return 0 }
		default { throw }
	}
}


function CanReduce ($n)
{
	switch ($n)
	{
		0 { return 0 }
		1 { return 0 }
		2 { return 0 }
		3 { return 0 }
		4 { return 0 }
		5 { return 0 }
		6 { return 0 }
		7 { return 0 }
		8 { return 0 }
		9 { return 0 }
		11 { return 0 }
		22 { return 0 }
		33 { return 0 } 
		default { return 1 }
	}
}


function ReduceNumber ($n)
{
	if (CanReduce($n))
	{
		$sn = [string]($n)
		$accu = CreateSumExpressionNumbers($sn)
		$reduced = Invoke-Expression($accu)
		ReduceNumber([int]$reduced)
	}
	else
	{
		return $n
	}
}

function ReduceName ($n)
{
	$sn = [string]($n)
	$accu = CreateSumExpressionLetters($sn)
	$reduced = Invoke-Expression($accu)
	ReduceNumber([int]$reduced)
}

function ReduceNameVowels ($n)
{
	$sn = [string]($n)
	$accu = CreateSumExpressionLettersVowels($sn)
	$reduced = Invoke-Expression($accu)
	ReduceNumber([int]$reduced)
}

function ReduceNameConsonants ($n)
{
	$sn = [string]($n)
	$accu = CreateSumExpressionLettersConsonants($sn)
	$reduced = Invoke-Expression($accu)
	ReduceNumber([int]$reduced)
}


function CreateSumExpressionLetters ($sn)
{
		$accu = ""
		
		foreach ($l in $sn.ToCharArray())
		{
			$lv = LookupLetterValue($l)
			$accu = $accu + $lv + "+"
		}
		
		$accu = $accu.Substring(0,$accu.Length-1)

		return $accu
}


function CreateSumExpressionLettersVowels ($sn)
{
		$accu = ""
		
		foreach ($l in $sn.ToCharArray())
		{
			if (IsVowel($l))
			{
				$lv = LookupLetterValue($l)
				$accu = $accu + $lv + "+"
			}
		}
		
		$accu = $accu.Substring(0,$accu.Length-1)

		return $accu
}



function CreateSumExpressionLettersConsonants ($sn)
{
		$accu = ""
		
		foreach ($l in $sn.ToCharArray())
		{
			if (!(IsVowel($l)))
			{
				$lv = LookupLetterValue($l)
				$accu = $accu + $lv + "+"
			}
		}
		
		$accu = $accu.Substring(0,$accu.Length-1)

		return $accu
}




function CreateSumExpressionNumbers ($sn)
{
		$accu = ""
		
		foreach ($l in $sn.ToCharArray())
		{
			$accu = $accu + $l + "+"
		}
		
		$accu = $accu.Substring(0,$accu.Length-1)

		return $accu
}


function IsVowel ($s)
{
	switch ($s)
	{
		"A" { return 1 }
		"E" { return 1 }
		"I" { return 1 }
		"O" { return 1 }
		"U" { return 1 }
		"Y" { return 1 }
		default { return 0 }
	}
}


function GetNameChunks ($s)
{
	$ar = $s.Split(" ")
	return $ar
}



function CreateKarmicNumberSequence ($s)
{
	$numbersstring = ""
	$karmicnumbersequence = "123456789"
	
	foreach ($l in $s.ToCharArray())
	{
		$numbersstring = $numbersstring + [string](LookupLetterValue($l))
	}

	if ($numbersstring.Contains("1")) { $karmicnumbersequence = $karmicnumbersequence.Replace("1","")}
	if ($numbersstring.Contains("2")) { $karmicnumbersequence = $karmicnumbersequence.Replace("2","")}
	if ($numbersstring.Contains("3")) { $karmicnumbersequence = $karmicnumbersequence.Replace("3","")}
	if ($numbersstring.Contains("4")) { $karmicnumbersequence = $karmicnumbersequence.Replace("4","")}
	if ($numbersstring.Contains("5")) { $karmicnumbersequence = $karmicnumbersequence.Replace("5","")}
	if ($numbersstring.Contains("6")) { $karmicnumbersequence = $karmicnumbersequence.Replace("6","")}
	if ($numbersstring.Contains("7")) { $karmicnumbersequence = $karmicnumbersequence.Replace("7","")}
	if ($numbersstring.Contains("8")) { $karmicnumbersequence = $karmicnumbersequence.Replace("8","")}
	if ($numbersstring.Contains("9")) { $karmicnumbersequence = $karmicnumbersequence.Replace("9","")}
	if ($numbersstring.Contains("0")) { $karmicnumbersequence = $karmicnumbersequence.Replace("0","")}
	
	return $karmicnumbersequence
}


#main
#get input parameters
$birthname = read-host "Birth Name: " 
$currentname = read-host "Current Name: "
$birthdate = read-host "Birth Date (MM/DD/YYYY): "
#treat the date as a real date
$birthrealdate = [datetime]($birthdate)


#show input params for review
Write-Host "Generating Numerology report for"
Write-Host "Birth name: $birthname"
Write-Host "Current name: $currentname"
Write-Host "Birth date: $birthrealdate" 



#Life path number
$m = ReduceNumber($birthrealdate.month)
$d = ReduceNumber($birthrealdate.day)
$y = ReduceNumber($birthrealdate.year)
$lifepathtotal = ReduceNumber([int]$m + [int]$d + [int]$y)
write-host "Life Path number: $lifepathtotal"



#Soul number
# only vowels
# TODO (refactor): chunk the parts of the name then recombine (like with date parts)
$expression = ""
foreach ($part in GetNameChunks($birthname))
{
	$expression = $expression + [string](ReduceNameVowels($part)) + "+"
}
$expression = $expression.Substring(0,$expression.Length-1)
#write-host $expression
$namessum = Invoke-Expression($expression)
$soulnumber = ReduceNumber([int]$namessum)
Write-Host "Soul number: $soulnumber"



#Personality number
# only consonants
# TODO (refactor): chunk the parts of the name then recombine (like with date parts)
$expression = ""
foreach ($part in GetNameChunks($birthname))
{
	$expression = $expression + [string](ReduceNameConsonants($part)) + "+"
}
$expression = $expression.Substring(0,$expression.Length-1)
#write-host $expression
$namessum = Invoke-Expression($expression)
$personalitynumber = ReduceNumber([int]$namessum)
Write-Host "Personality number: $personalitynumber"




#Destiny number
# TODO (refactor): chunk the parts of the name then recombine (like with date parts)
$expression = ""
foreach ($part in GetNameChunks($birthname))
{
	$expression = $expression + [string](ReduceName($part)) + "+"
}
$expression = $expression.Substring(0,$expression.Length-1)
#write-host $expression
$namessum = Invoke-Expression($expression)
$destinynumber = ReduceNumber([int]$namessum)
Write-Host "Destiny number: $destinynumber"



#Maturity number
$maturitynumber = ReduceNumber($lifepathtotal + $destinynumber)
Write-Host "Maturity number: $maturitynumber"



#Current name number
$expression = ""
foreach ($part in GetNameChunks($currentname))
{
	$expression = $expression + [string](ReduceName($part)) + "+"
}
$expression = $expression.Substring(0,$expression.Length-1)
#write-host $expression
$namessum = Invoke-Expression($expression)
$currentnamenumber = ReduceNumber([int]$namessum)
Write-Host "Current name number: $currentnamenumber"



#Birth day number
$d = ReduceNumber($birthrealdate.day)
Write-Host "Birth day number: $d"



#Karmic numbers
$k = CreateKarmicNumberSequence($birthname)
Write-Host "Karmic numbers: $k"







#wait
write-host "Done."
write-host ""
write-host ""

read-host "Press enter to close."


