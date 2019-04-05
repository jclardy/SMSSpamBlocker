# coding: utf-8

import unicodecsv as csv

def main():
	with open('query_result.csv', 'rb') as csv_file, open('fulldata.csv', 'w') as csv_out:
		csv_reader = csv.reader(csv_file, delimiter=',')
		line_count = 0
		for row in csv_reader:
			if len(row) < 2:
				continue
			rowText = row[0].replace("\n"," ").replace("\r"," ").replace("\\", "").replace('"', "")
			rowSpamType = "safe"
			if row[1] == 1:
				rowSpamType = "spam"
			if row[1] == "1":
				rowSpamType = "spam"
			csv_out.write(f'"{rowText}","{rowSpamType}"\n')
			print(f'"{rowText}","{rowSpamType}"')
			line_count += 1
		print(f'Processed {line_count} lines.')

if __name__ == '__main__':
	main()
