# SArchiver

A CLI app to compress and decompress various files into various compression formats. Supported compression formats: Zip, Tar 

## Installation

### 1. Using binary executable

#### Download latest binary release from [here](https://github.com/surajkarki66/SArchiver/releases/tag/sarchiver0.0.1)

```bash
  $ ./sarchiver
```
### 2. Using Pub.dev

```bash
  $ dart pub global activate sarchiver
```

### 3. Manual

```bash
  $ git clone https://github.com/surajkarki66/SArchiver
  $ cd SArchiver
  $ dart run ./bin/sarchiver.dart
```

## Usage

```bash
  $ sarchiver <command> [arguments]
```

**Global Options**

-h, --help<br>
Display help


**Available Commands**

compress<br>
Compress files into a specific compression format.

decompress<br>
Decompress the compressed file into original files.

**Compress Arguments**

-i, --input-path<br>          
Specify path to input file or directory

-o, --output-file-path<br>
Specify path to store compressed file

-f, --format<br>              
Specify compression file format [zip (default), tar]

**Decompress Arguments**

-i, --input-file-path<br>          
Specify path to input compressed file

-o, --output-file-path<br>
Specify path to store decompressed file


---

## Help

```bash
  $ sarchiver --help
```

## Examples

Below are some examples of sarchiver usage.

- Compress the file in the current directory and store the compressed file in the current directory:

```bash
  $ ./sarchiver compress -i passport.pdf -o ./
```

Loading...<br>
Compressed 1  into ./1683283436296.zip

- Decompress the compressed file in the current directory and store the decompressed file in the current directory.

```bash
  $ ./sarchiver decompress -i 1683283436296.zip -o ./
```

Decompressed: passport.pdf (450222 bytes)<br>
Loading...

- Compressing multiple files into a single compressed file and storing it in the current directory:

```bash
  $ ./sarchiver compress -i passport.pdf,resume.pdf,IMG_7569.jpg -o ./
```

Loading...<br>
Compressed 3  into ./1683284112543.zip

- Compressing multiple files into a tar file and storing it in the current directory:


```bash
  $ ./sarchiver compress -i passport.pdf,resume.pdf,IMG_7569.jpg -o ./ -f tar
```

Loading...<br>
Compressed 3  into ./1683284266080.tar