nextflow.enable.dsl=2

// Define input parameters with sensible container defaults
params.taxid = "" 
params.data_dir = "/app/data" 
params.email = "" 
params.api_key = "" 

process RUN_SETUP {
	// Nextflow uses this exact image to run this step automatically
	container 'vcfgenerator:latest'
    
	output: 
	path "VCF.projects/${params.taxid}/raw_inputs/*", emit: raw_fastq 
	
	script: 
	""" 
	export DATA_DIR="${params.data_dir}" 
	export TAXID="${params.taxid}" 
	export NCBIO_EMAIL="${params.email}" 
	export NCBI_API_KEY="${params.api_key}"
    
	bash /app/setup.sh 
	"""
}

process RUN_TRIMQC { 
	container 'vcfgenerator:latest'
    
	input: 
	path fastq_files
    
	output: 
	path "VCF.projects/${params.taxid}/trimmed/*", emit: trimmed_fastq 

	script: 
	""" 
	export DATA_DIR="${params.data_dir}" 
	export TAXID="${params.taxid}"
    
	bash /app/trimqc.sh 
	"""
}

process RUN_VCF { 
	container 'vcfgenerator:latest'

	input: 
	path trimmed_files
    
	output: 
	path "VCF.projects/${params.taxid}/variants/*.vcf", emit: raw_vcf 

	script: 
	""" 
	export DATA_DIR="${params.data_dir}" 
	export TAXID="${params.taxid}"
    
	bash /app/VCF.sh 
	"""
}

process RUN_ANNOTATION { 
	container 'vcfgenerator:latest'

	input: 
	path raw_vcf 

	script: 
	""" 
	export DATA_DIR="${params.data_dir}" 
	export TAXID="${params.taxid}"
    
	bash /app/annotation.sh 
	"""
}

workflow {
	// Connect your existing shell scripts into a continuous reactive stream
	setup_ch = RUN_SETUP() 
	trim_ch = RUN_TRIMQC(setup_ch.raw_fastq) 
	vcf_ch = RUN_VCF(trim_ch.trimmed_fastq) 
	RUN_ANNOTATION(vcf_ch.raw_vcf)
}

