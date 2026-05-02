"""
PATH: src/ingest/content_detector.py
PURPOSE: Analyzes PDF pages to determine the best ingestion pipeline.
PHASE: 1
TASK: P1-D4B
"""

import os
import sys
import logging
import fitz
from typing import Dict, List, Any

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)

def analyse_page(page: fitz.Page) -> Dict[str, Any]:
    """
    Analyzes a single PDF page for text and image content.
    
    Args:
        page (fitz.Page): The PyMuPDF page object.
        
    Returns:
        Dict[str, Any]: Page analysis results including counts and classification.
    """
    text = page.get_text()
    char_count = len(text)
    image_count = len(page.get_images())
    
    # Heuristic for text ratio: roughly chars / (chars + image_weight)
    # This is a simplification; image weight could be based on area.
    image_weight = image_count * 500  # Assume 1 image is equivalent to 500 chars for ratio
    total_weight = char_count + image_weight
    text_ratio = char_count / total_weight if total_weight > 0 else 0
    
    if image_count > 0 and char_count < 200:
        classification = "image_heavy"
    elif char_count > 1000 and image_count == 0:
        classification = "text_heavy"
    else:
        classification = "mixed"
        
    return {
        "page_num": page.number + 1,
        "char_count": char_count,
        "image_count": image_count,
        "text_ratio": round(text_ratio, 2),
        "classification": classification
    }

def detect_pipeline(pdf_path: str) -> Dict[str, Any]:
    """
    Analyzes the entire PDF and recommends an ingestion pipeline.
    
    Args:
        pdf_path (str): Path to the PDF file.
        
    Returns:
        Dict[str, Any]: PDF analysis summary and recommendation.
    """
    if not os.path.exists(pdf_path):
        raise FileNotFoundError(f"PDF not found: {pdf_path}")
        
    doc = fitz.open(pdf_path)
    page_details = []
    summary_counts = {"image_heavy": 0, "text_heavy": 0, "mixed": 0}
    
    for page in doc:
        analysis = analyse_page(page)
        page_details.append(analysis)
        summary_counts[analysis["classification"]] += 1
        
    total_pages = len(doc)
    doc.close()
    
    image_heavy_pct = (summary_counts["image_heavy"] / total_pages) * 100 if total_pages > 0 else 0
    text_heavy_pct = (summary_counts["text_heavy"] / total_pages) * 100 if total_pages > 0 else 0
    
    if image_heavy_pct > 60:
        recommendation = "VISION_PIPELINE"
    elif text_heavy_pct > 60:
        recommendation = "TEXT_PIPELINE"
    else:
        recommendation = "HYBRID_PIPELINE"
        
    return {
        "file": os.path.basename(pdf_path),
        "pages": total_pages,
        "breakdown": summary_counts,
        "recommendation": recommendation,
        "page_details": page_details
    }

def main():
    """Main entry point for the script."""
    if len(sys.argv) < 2:
        logger.error("Usage: python content_detector.py <pdf_path>")
        sys.exit(1)
        
    pdf_path = sys.argv[1]
    
    try:
        report = detect_pipeline(pdf_path)
        
        print("═══════════════════════════════════════")
        print("MY MENTOR — CONTENT DETECTOR")
        print("═══════════════════════════════════════")
        print(f"File         : {report['file']}")
        print(f"Total Pages  : {report['pages']}")
        print("───────────────────────────────────────")
        print("Page Analysis:")
        for page in report["page_details"]:
            print(f"  Page {page['page_num']} : {page['classification']} ")
            print(f"           chars={page['char_count']} images={page['image_count']} ratio={page['text_ratio']}")
        print("───────────────────────────────────────")
        print("Summary:")
        print(f"  Image Heavy : {report['breakdown']['image_heavy']} pages")
        print(f"  Text Heavy  : {report['breakdown']['text_heavy']} pages")
        print(f"  Mixed       : {report['breakdown']['mixed']} pages")
        print("───────────────────────────────────────")
        print(f"PIPELINE     : {report['recommendation']}")
        print("═══════════════════════════════════════")
        
    except Exception as e:
        logger.error(f"Error during detection: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()
