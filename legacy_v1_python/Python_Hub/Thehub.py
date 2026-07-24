##LJones, JRobinson, NLuu 
## Holds the shell scripts that run the workflow and acts as a hub for the input variables set in Controller.py
## Import Libraries 
import subprocess
# Workflow shell scripts 
download = subprocess.call(["python3","download.py"]) ## Search and Download scripts, splits files if necessary 
trim  = subprocess.call(["python3","trimmomatic.py"]) ## runs trimmomatic 
variants = subprocess.call(["python3","variants.py"]) ## Variant calling workflow loop
annotation = subprocess.call(["python3","annotations.py"]) ## Final Variant calling annotation script
