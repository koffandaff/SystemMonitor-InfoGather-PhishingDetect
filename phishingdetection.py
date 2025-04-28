import re, requests, whois, tldextract
from urllib.parse import urlparse

def check_url_features(url):
    report = {}

    # Feature 1: URL length
    report['url_length'] = len(url)
    report['is_long'] = len(url) > 75

    # Feature 2: Use of IP instead of domain
    report['has_ip'] = bool(re.match(r'http[s]?://\d+\.\d+\.\d+\.\d+', url))

    # Feature 3: Presence of '@'
    report['has_at'] = '@' in url

    # Feature 4: Too many '-'
    domain = urlparse(url).netloc
    report['has_many_hyphens'] = domain.count('-') > 3

    # Feature 5: Subdomain depth
    subdomain = tldextract.extract(url).subdomain
    report['subdomain_depth'] = subdomain.count('.') + 1 if subdomain else 0
    report['is_deep_subdomain'] = report['subdomain_depth'] > 2

    # Feature 6: Whois Domain Age
    try:
        w = whois.whois(domain)
        creation_year = w.creation_date.year if w.creation_date else None
        report['domain_age_years'] = 2025 - creation_year if creation_year else -1
        report['is_new_domain'] = report['domain_age_years'] < 1
    except:
        report['is_new_domain'] = True

    return report

def classify(report):
    # Simple rule-based system
    flags = sum([
        report['is_long'],
        report['has_ip'],
        report['has_at'],
        report['has_many_hyphens'],
        report['is_deep_subdomain'],
        report['is_new_domain']
    ])
    if flags >= 4:
        return "Phishing"
    elif flags >= 2:
        return "Suspicious"
    else:
        return "Safe"

# === Test it ===
url = input("Enter a URL to check: ")
report = check_url_features(url)
result = classify(report)

print("\n[+] Analysis Report:")
for k, v in report.items():
    print(f"{k}: {v}")
print(f"\nResult: {result}")
