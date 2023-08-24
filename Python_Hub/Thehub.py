##LJones, JRobinson, NLuu 
## Holds the shell scripts that run the workflow and acts as a hub for the input variables set in Controller.py
## Import Libraries 
import subprocess
# Workflow shell scripts 
download = subprocess.call(["python","download.py"]) ## Search and Download scripts, splits files if necessary 
trim  = subprocess.call(["python","trimmmomatic.py"]) ## runs trimmomatic 
variants = subprocess.call(["python","variants.py"]) ## Variant calling workflow loop
annotation = subprocess.call(["python","annotations.py"]) ## Final Variant calling annotation script
