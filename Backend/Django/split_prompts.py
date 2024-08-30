# The program will automatically convert the title of each topic into a filename, so you need to separate different topics with "---"

import os
import argparse

def split_topics(input_file, output_dir):
    # Create the output directory if it doesn't exist
    if not os.path.exists(output_dir):
        os.makedirs(output_dir)

    with open(input_file, 'r', encoding='utf-8') as file:
        content = file.read()

    # Split the content into topics
    topics = content.split('---')

    # Process each topic
    for i, topic in enumerate(topics, 1):
        topic = topic.strip()
        if topic:
            # Extract the title (first line) of the topic
            title = topic.split('\n')[0].strip()
            # Create a valid filename from the title
            filename = f"topic_{i}_{title.lower().replace(' ', '_')[:100]}.txt"
            file_path = os.path.join(output_dir, filename)

            # Write the topic to a new file
            with open(file_path, 'w', encoding='utf-8') as output_file:
                output_file.write(topic)

            print(f"Created file: {filename}")

# Using the script
if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Split a text file into multiple files based on topics.')
    parser.add_argument('input_file', nargs='?', default='django-prompts.txt', help='Path to the input file')
    parser.add_argument('output_dir', nargs='?', default='split_doc_directory', help='Directory to save the output files')
    args = parser.parse_args()

    split_topics(args.input_file, args.output_dir)