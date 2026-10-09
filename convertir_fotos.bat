@echo off
chcp 65001 >nul
echo ======================================================
echo    OPTIMIZADOR DE FOTOS WEB - ÁMBAR BOLSOS
echo ======================================================
echo 1. Buscando fotos HEIC de iPhone y convirtiéndolas a JPG...
echo 2. Optimizando resolución y comprimiendo para carga ultra-rápida...
echo.

python -c "import os, sys; from PIL import Image, ImageOps; import pillow_heif; pillow_heif.register_heif_opener(); dirs = [r'assets\bolsos', r'assets\bolsos\bolsos_jpg']; max_dim = 1600; count = 0; [ [None for f in os.listdir(d) if f.lower().endswith(('.heic', '.jpg', '.jpeg')) and (lambda p, name, ext: (ImageOps.exif_transpose(Image.open(p)).convert('RGB').save(os.path.join(d, os.path.splitext(f)[0] + '.jpg'), 'JPEG', quality=84, optimize=True, progressive=True) if ext == '.heic' else (Image.open(p).size[0] > max_dim or Image.open(p).size[1] > max_dim) and (lambda img: (img.thumbnail((max_dim, max_dim), Image.Resampling.LANCZOS), img.save(p, 'JPEG', quality=84, optimize=True, progressive=True)))(ImageOps.exif_transpose(Image.open(p)).convert('RGB')), sys.stdout.write(f'Procesada: {f}\n')))(os.path.join(d, f), os.path.splitext(f)[0], os.path.splitext(f)[1].lower())] for d in dirs if os.path.exists(d)]; print('\nProceso completado con éxito.')"

echo.
echo ======================================================
echo  ¡Listo! Todas tus fotos están optimizadas para la web.
echo ======================================================
echo.
pause
