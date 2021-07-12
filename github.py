import requests
from datetime import datetime

response = requests.get("https://api.github.com/users/zmcguckin/repos")

data = response.json()

for repo in data:
    file = open("Content/projects/" + repo["name"] + ".md", "w")
    file.write("---\n")
    date = repo["updated_at"]
    clean_date = datetime.strptime(date, '%Y-%m-%dT%H:%M:%SZ')
    clean_date = clean_date.strftime('%Y-%m-%d %H:%M')
    file.write("date: " + clean_date + "\n")
    file.write("description: " + (repo["description"] or "No description") + "\n")
    file.write("tags: " + (repo["language"].lower() + ", " if repo["language"] else "") + "projects\n")
    file.write("---\n")
    file.write("\n")
    file.write("# " + repo["name"] + "\n")
    file.write("\n")
    file.write("[View on Github](" + repo["html_url"] + ")\n")
    file.close()
