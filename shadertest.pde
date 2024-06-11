import java.io.File;
import processing.video.*;

Object[][] media; // Array to store both images and videos
int topicIndex = 0;
int mediaIndex = 0;
int numTopics = 0;
int[] numMediaPerTopic;
String basePath = "archivo/";

void setup() {
  size(800, 600);
  loadMedia();
  displayMedia();
}

void draw() {
  // Continuously redraw the image if needed
  if (media[topicIndex].length > 0 && media[topicIndex][mediaIndex] instanceof Movie) {
    Movie movie = (Movie) media[topicIndex][mediaIndex];
    image(movie, 0, 0, width, height);
  }
}

void loadMedia() {
  File baseFolder = new File(dataPath(basePath));
  if (!baseFolder.exists() || !baseFolder.isDirectory()) {
    println("Base folder not found: " + baseFolder.getAbsolutePath());
    return;
  }

  println("Base folder path: " + baseFolder.getAbsolutePath());
  
  String[] topicFolders = baseFolder.list((dir, name) -> new File(dir, name).isDirectory());

  if (topicFolders == null || topicFolders.length == 0) {
    println("No topic folders found");
    return;
  }

  // Count topics and initialize media array
  numTopics = topicFolders.length;
  media = new Object[numTopics][];
  numMediaPerTopic = new int[numTopics];

  for (int i = 0; i < numTopics; i++) {
    File topicFolder = new File(baseFolder, topicFolders[i]);
    println("Loading topic folder: " + topicFolder.getAbsolutePath());

    String[] mediaFiles = topicFolder.list((dir, name) -> name.toLowerCase().endsWith(".jpg") || name.toLowerCase().endsWith(".mp4"));

    if (mediaFiles == null || mediaFiles.length == 0) {
      println("No media found in topic folder " + topicFolders[i]);
      numMediaPerTopic[i] = 0;
      continue;
    }

    numMediaPerTopic[i] = mediaFiles.length;
    media[i] = new Object[mediaFiles.length];

    for (int j = 0; j < mediaFiles.length; j++) {
      String mediaPath = basePath + topicFolders[i] + "/" + mediaFiles[j];
      if (mediaFiles[j].toLowerCase().endsWith(".jpg")) {
        media[i][j] = loadImage(mediaPath);
        if (media[i][j] == null) {
          println("Failed to load image: " + mediaPath);
        } else {
          println("Loaded image: " + mediaPath);
        }
      } else if (mediaFiles[j].toLowerCase().endsWith(".mp4")) {
        Movie movie = new Movie(this, mediaPath);
        movie.noLoop(); // Don't start playing immediately
        media[i][j] = movie;
        if (media[i][j] == null) {
          println("Failed to load video: " + mediaPath);
        } else {
          println("Loaded video: " + mediaPath);
        }
      }
    }
  }
}

void displayMedia() {
  background(0);
  if (media[topicIndex].length > 0 && media[topicIndex][mediaIndex] != null) {
    if (media[topicIndex][mediaIndex] instanceof PImage) {
      PImage img = (PImage) media[topicIndex][mediaIndex];
      image(img, 0, 0, width, height);
    } else if (media[topicIndex][mediaIndex] instanceof Movie) {
      Movie movie = (Movie) media[topicIndex][mediaIndex];
      movie.play();
    }
  } else {
    println("No media to display for topic " + topicIndex + ", media " + mediaIndex);
  }
}

void keyPressed() {
  if (keyCode == RIGHT) {
    // Move to next topic
    topicIndex = (topicIndex + 1) % numTopics;
    mediaIndex = 0; // reset media index
  } else if (keyCode == LEFT) {
    // Move to previous topic
    topicIndex = (topicIndex - 1 + numTopics) % numTopics;
    mediaIndex = 0; // reset media index
  } else if (keyCode == UP) {
    // Move to previous media in the current topic
    mediaIndex = (mediaIndex - 1 + numMediaPerTopic[topicIndex]) % numMediaPerTopic[topicIndex];
  } else if (keyCode == DOWN) {
    // Move to next media in the current topic
    mediaIndex = (mediaIndex + 1) % numMediaPerTopic[topicIndex];
  }
  displayMedia();
}

// Handle movie playback
void movieEvent(Movie m) {
  m.read();
}
