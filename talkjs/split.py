import re

def split_docs(input_file, output_dir):
  """Splits a consolidated documentation file into separate files based on title markers.

  Args:
    input_file: Path to the consolidated documentation file.
    output_dir: Path to the directory where the separate files will be saved.
  """

  with open(input_file, 'r') as f:
    content = f.read()

  docs = re.split(r'---\ntitle: ', content)

  for i, doc in enumerate(docs):
    if i == 0:  # Skip the first part before the first title
      continue

    # # Extract the title from the doc
    # title_match = re.search(r'^(.*?)\n', doc)
    # if title_match:
    #   title = title_match.group(1).strip()
    # else:
     

    # Sanitize the title for filename
    # title = re.sub(r'[^\w\s-]', '', title).strip().replace(' ', '_')

    # Save the doc to a separate file
    title = f"doc_{i}"
    output_file = f"{output_dir}/{title}.txt"
    with open(output_file, 'w') as f:
      f.write(doc)

if __name__ == "__main__":
  input_file = "/Users/samyak/Downloads/all_docs.txt"
  output_dir = "/Users/samyak/Documents/commanddash/default_agents/talkjs/assets/docs"
  split_docs(input_file, output_dir)