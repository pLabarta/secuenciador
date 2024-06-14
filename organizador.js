const fs = require('fs');
const path = require('path');

function organizeFiles(inputDir, outputDir) {
  // Asegúrate de que el directorio de salida existe
  if (!fs.existsSync(outputDir)) {
    fs.mkdirSync(outputDir, { recursive: true });
  }

  let folderCounter = 1;
  let fileCounter = 1;
  let currentSubfolder = path.join(outputDir, String(folderCounter));

  if (!fs.existsSync(currentSubfolder)) {
    fs.mkdirSync(currentSubfolder);
  }

  const files = fs.readdirSync(inputDir).sort();

  files.forEach(file => {
    const filePath = path.join(inputDir, file);

    if (fs.statSync(filePath).isFile() && /\.(jpg|jpeg|png|mp4|avi|mov)$/i.test(file)) {
      const newFileName = `${fileCounter}-${file}`;
      const newFilePath = path.join(currentSubfolder, newFileName);

      fs.renameSync(filePath, newFilePath);

      fileCounter++;

      if (fileCounter > 10) {
        folderCounter++;
        fileCounter = 1;
        currentSubfolder = path.join(outputDir, String(folderCounter));

        if (!fs.existsSync(currentSubfolder)) {
          fs.mkdirSync(currentSubfolder);
        }
      }
    }
  });
}

// Directorio de entrada y salida
const inputDir = path.resolve(__dirname, 'input');
const outputDir = path.resolve(__dirname, 'data/archivo');

// Ejecuta la función para organizar los archivos
organizeFiles(inputDir, outputDir);

console.log("Archivos organizados correctamente.");
