files = lutherbook
DIRS = css js

INCLUDES = luthercottagehistory.xml lutherlothistory.xml lutherrecipes.xml lutherbotantical.xml
INCLUDES_XML = $(addprefix ../, $(INCLUDES))

FILES_XML = $(addsuffix .xml, $(files))
FILES_XHTML = $(addsuffix .html, $(files))

XHTML_OUTPUTS_TARGS = $(patsubst %,./%,$(FILES_XHTML))
OUTPUT_TARGS = $(XHTML_OUTPUTS_TARGS)

PROJECT_ID := wtm-webserver
ZONE       := us-central1-f
INSTANCE   := instance-20250916-163450

SAXON := ../SaxonHE12-8J/saxon-he-12.8.jar

# Define file paths.
LOCAL_PROJECT_DIR := /Users/wtm/Documents/books/ELY
LOCAL_PROJECT_HTML := $(LOCAL_PROJECT_DIR)/xhtml

LOCAL_FILE  := lutherbook.html
REMOTE_FILE := /var/www/html/ELY/lutherbook.html
REMOTE_PROJECT_DIR = /var/www/html/ELY
REMOTE_PROJECT_HTML = /var/www/html/ELY

REMOTE_PROJECT_IMAGES = /var/www/html/ELY/Images
LOCAL_PROJECT_CSS = css
REMOTE_PROJECT_CSS = /var/www/html/ELY/css

.PHONY: all clean images xhtml upload download upload_js upload_images

.PRECIOUS: *.html
.SECONDARY:

all: xhtml

xhtml: $(INCLUDES_XML) $(XHTML_OUTPUTS_TARGS)

%.xml: 

%.xsl:

$(INCLUDES_XML):

%.html: xml=../$(addsuffix .xml, $*)
%.html: xsl=$(addsuffix .xsl, $*)
%.html: %.xsl
	java  -jar $(SAXON) -s:$(xml) -xsl:$(xsl) -xi:on -o:$@

clean:
	rm -f $(XHTML_OUTPUTS_TARGS)



# Target to upload a file from your local machine to the VM.
#upload: $(FILES_XHTML) upload_images upload_dirs 
upload: $(FILES_XHTML)
	@echo "Uploading $(FILES_XHTML) to $(INSTANCE):$(REMOTE_PROJECT_DIR)..."
	gcloud compute scp $(FILES_XHTML) $(INSTANCE):$(REMOTE_PROJECT_DIR) \
		--project=$(PROJECT_ID) --zone=$(ZONE)


# Target to download a file from the VM to your local machine.
download:
	@echo "Downloading $(INSTANCE):$(REMOTE_FILE) to $(LOCAL_FILE)..."
	gcloud compute scp $(INSTANCE):$(REMOTE_FILE) $(LOCAL_FILE) \
		--project=$(PROJECT_ID) --zone=$(ZONE)

%.html: xsl=$(addsuffix .xsl, $*)
%.xhtmlxs: %.xsl
	java  -jar $(SAXON) -s:$(xml) -xsl:$(xsl) -xi:on -o:$@

%.xsl:

upload_images: IMAGES := $(shell java  -jar $(SAXON) -s:../lutherbook.xml -xsl:images.xsl -xi:on)
upload_images: IMAGE_FILES := $(addsuffix .jpg, $(IMAGES))
upload_images: what = $(foreach a, $(IMAGE_FILES), Images/$(a) )
upload_images: 
	@echo "Uploading $(what) to $(INSTANCE):$(REMOTE_PROJECT_IMAGES)..."
	gcloud compute scp $(what) $(INSTANCE):$(REMOTE_PROJECT_IMAGES) \
		--project=$(PROJECT_ID) --zone=$(ZONE)

upload_dirs: 
	@echo "Uploading $(DIRS) to $(INSTANCE):$(REMOTE_PROJECT_HTML)..."
	gcloud compute scp --recurse $(DIRS) $(INSTANCE):$(REMOTE_PROJECT_HTML)\
		--project=$(PROJECT_ID) --zone=$(ZONE)
