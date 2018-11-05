import csv

FILE = "test.csv"


def csv_to_dict_list(csv_file):
    with open(csv_file, "r", encoding="utf-8") as fh:
        #reader = csv.DictReader(open(csv_file, "r", encoding="utf-8"), delimiter=",")
        reader = csv.DictReader(fh, delimiter=",")
        dict_list=[]
        for row in reader:
            print(row)
            d = {}
            for key in row.keys():
                d[key] = row[key]
                dict_list.append(d)
    return dict_list


dict_list = csv_to_dict_list("test.csv")

print(dict_list)


