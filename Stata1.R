#dummy variables 
gen Q47_1 = 1 if Q47 == 1
replace Q47_1 = 0 if Q47 != 1
gen Q47_2 = 1 if Q47 == 2
replace Q47_2 = 0 if Q47 != 2
gen Q47_3 = 1 if Q47 == 3
replace Q47_3 = 0 if Q47 != 3
gen Q47_4 = 1 if Q47 == 4
replace Q47_4 = 0 if Q47 != 4
gen Q47_5 = 1 if Q47 == 5
replace Q47_5 = 0 if Q47 != 5

label variable Q46 ""

rename Q46 Happiness

label variable Q47 ""

rename Q47 State of health

label variable Q131 ""

rename Q131 Feeling secure 

label variable Q287 ""

rename Q287  Social class

label variable Q112 ""

rename Q112 Perception_of_corruption
label variable Q260 ""

rename Q260 Gender

label variable Q260 ""
mlogit Happiness i.State_of_health i.Feeling_secure i.Social_class i.Importance_of_God i.Perception_of_corruption i.Gender  ,rrr
mlogitgof


gen Q131_1 = 1 if Q131 == 1
replace Q131_1 = 0 if Q131 != 1
gen Q131_2 = 1 if Q131 == 2
replace Q131_2 = 0 if Q131 != 2
gen Q131_3 = 1 if Q131 == 3
replace Q131_3 = 0 if Q131 != 3
gen Q131_4 = 1 if Q131 == 4
replace Q131_4 = 0 if Q131 != 4



gen Q287_1 = 1 if Q287 == 1
replace Q287_1 = 0 if Q287 != 1
gen Q287_2 = 1 if Q287 == 2
replace Q287_2 = 0 if Q287 != 2
gen Q287_3 = 1 if Q287 == 3
replace Q287_3 = 0 if Q287 != 3
gen Q287_4 = 1 if Q287 == 4
replace Q287_4 = 0 if Q287 != 4
gen Q287_5 = 1 if Q287 == 5
replace Q287_5 = 0 if Q287 != 5



gen Q164_1 = 1 if Q164 == 1
replace Q164_1 = 0 if Q164 != 1
gen Q164_2 = 1 if Q164 == 2
replace Q164_2 = 0 if Q164 != 2
gen Q164_3 = 1 if Q164 == 3
replace Q164_3 = 0 if Q164 != 3
gen Q164_4 = 1 if Q164 == 4
replace Q164_4 = 0 if Q164 != 4
gen Q164_5 = 1 if Q164 == 5
replace Q164_5 = 0 if Q164 != 5



gen Q112_1 = 1 if Q112 == 1
replace Q112_1 = 0 if Q112 != 1
gen Q112_2 = 1 if Q112 == 2
replace Q112_2 = 0 if Q112 != 2
gen Q112_3 = 1 if Q112 == 3
replace Q112_3 = 0 if Q112 != 3
gen Q112_4 = 1 if Q112 == 4
replace Q112_4 = 0 if Q112 != 4
gen Q112_5 = 1 if Q112 == 5
replace Q112_5 = 0 if Q112 != 5



gen Q260_1 = 1 if Q260 == 1
replace Q260_1 = 0 if Q260!= 1
gen Q260_2 = 1 if Q260 == 2
replace Q260_2 = 0 if Q260 != 2



gen Q47_2_Q260_2 = Q47_2 * Q260_2
gen Q47_3_Q260_2 = Q47_3 * Q260_2
gen Q47_4_Q260_2 = Q47_4 * Q260_2
gen Q47_5_Q260_2 = Q47_5 * Q260_2

logit Y i.Q47 i.Q131 i.Q287 i.Q164 i.Q112 i.Q260 Q47_2_Q260_2 Q47_3_Q260_2 Q47_4_Q260_2 Q47_5_Q260_2  ,or
xi: stepwise, pr(0.05):logit Y i.Q47 i.Q131 i.Q287 i.Q164 i.Q112 i.Q260 Q47_2_Q260_2 Q47_3_Q260_2 Q47_4_Q260_2 Q47_5_Q260_2  ,or
logit Y i.Q47 i.Q287  i.Q260 Q47_2_Q260_2 Q47_3_Q260_2 Q47_4_Q260_2 Q47_5_Q260_2  ,or
estat gof
estat ic
lsens
estat classification, cutoff(0.87)
lroc