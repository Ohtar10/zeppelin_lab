#!/usr/bin/python

import random

def is_ok(salary, properties, education_level, debts):
	pass

with open('./creditos.csv', 'w') as file:
	for i in range(1, 100):
		salary = random.randint(600, 10000)
		properties = random.randint(0, 100000)
		# 0. Not professional, 1. Professional, 2. Specialization, 3. Master, 4. Phd
		education_level = random.randint(0, 4)
		debts = random.randint(0, 100000)
		loan = random.randint(0, 1)
		file.write("{},{},{},{},{}\n".format(salary, properties, education_level, debts, loan))

	
