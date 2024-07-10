import re
import requests
from xml.etree import ElementTree as ET

def extract_urls_from_sitemap(sitemap_url, prefix):
    """Extracts and prints URLs matching a certain prefix from a given XML sitemap.

    Args:
        sitemap_url: URL of the XML sitemap.
        prefix: The prefix to match URLs against.
    """
    response = requests.get(sitemap_url)
    if response.status_code != 200:
        print(f"Failed to fetch sitemap: {response.status_code}")
        return

    # Parse the XML content
    root = ET.fromstring(response.content)

    # Extract URLs
    urls = [url.text for url in root.iter('{http://www.sitemaps.org/schemas/sitemap/0.9}loc')]

    # Filter URLs by prefix
    matching_urls = [url for url in urls if url.startswith(prefix)]

    # Print matching URLs
    print(matching_urls)

if __name__ == "__main__":
    sitemap_url = "https://talkjs.com/sitemap.xml"
    prefix = "https://talkjs.com/docs/Reference"
    extract_urls_from_sitemap(sitemap_url, prefix)