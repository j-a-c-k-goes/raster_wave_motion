color bg = #0F0F0F;
color fg = #FAFAEB;
PImage img;

void setup() {
  size(1920, 1080);
  background(bg);
  img = loadImage("shutterstock_1872101146.jpg");
  img.resize(width, height);
}

void draw() {
  background(bg);
  fill(fg);
  noStroke();

  float magnitude_a = 72;
  float magnitude_b = magnitude_a * -4;
  float size = 64;

  /* calculate aspect ratio of image for accurate tiling */
  float ratio = float(height)/float(width);

  /* bind number of tiles on x-axis to mouseX position */
  float tiles_x = map(mouseX, 0, width, 10, 100);

  /* calculate number of tiles for y-axis based on img aspect ratio */
  float tiles_y = ratio * tiles_x;

  /* calculate width and height of each tile */
  float tile_size = width / tiles_x;

  for (int y = 0; y < img.height; y += tile_size) {
    for (int x = 0; x < img.width; x += tile_size) {

      float phase_wave = map(sin(radians(frameCount * .05 + x)), -1, 1, -width / 4, height / 4);
      float wave_a = map(cos(radians(frameCount * 2.025 + y / 2)), -1, 1, -1, 1);
      float wave_b = map(cos(radians(frameCount * .075 + x + phase_wave)), -1, 1, -magnitude_b, magnitude_b);


      /* extract the color from current pixel and assign to var c */
      color c = img.get(x, y);

      /* calc brightness of c, map between 0 and 255 && 0 and 1 */
      float b = map(brightness(c), 0, 255, -1, 1);

      /* open a new matrix */
      pushMatrix();

      /* set position */
      translate(x + wave_a, y + phase_wave  / wave_b); 

      /* draw the tile */
      rectMode(CORNERS);
      rect(0, phase_wave * .075, b * tile_size, b * tile_size);

      /* draw the tile */
      //rect(0 + x, 0 + y, b * tile_size, b * tile_size);

      /* close matrix */
      popMatrix();
    }
  }
  saveFrame("out/frame####.jpg");
}
