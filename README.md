# Chew Sense – Data Collection and Labeling

Chew Sense records synchronized AirPods motion data and video for research, prototyping, and dataset creation. While optimized for chewing-related motion analysis, it can support any workflow requiring aligned video and AirPods motion samples.

---

## Features

### Automatic AirPods Connection
- The app connects to supported AirPods motion sensors on launch.  
- Recording is enabled only when motion data is actively available.

### Synchronized Recording
- Each session stores a `.mov` video file and a `.csv` motion-data file in a single folder.  
- Timestamps ensure precise alignment between modalities.

### Optional Labeling Workflow
- Recordings can be exported immediately when started in **Not eating** mode.  
- When labeling is required, the detail view supports:
  - Playback  
  - Marker placement  
  - Segment-based boolean labels  
- Segments between markers are labeled `true`; all others are `false`.

### Connection-Loss Protection
- The app automatically pauses recording if the AirPods connection drops.  
- This prevents incomplete or misaligned datasets.

---

## Data Format

- **Video:** `recording.mov`  
- **Motion data:** `motion.csv` with timestamped sensor rows  
- **Labels:** Boolean values aligned to motion-data segments  

---

## Exporting

Recordings can be exported or shared as a folder containing both files. This design simplifies downstream processing and machine-learning dataset assembly.

---

## Intended Use

Chew Sense is designed for technical users who need clean, consistent, and synchronized motion/video data.  
It is **not** intended as a consumer chewing-monitoring or health-tracking product.
