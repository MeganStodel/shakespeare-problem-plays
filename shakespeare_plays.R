library(tidyverse)
library(gutenbergr)

# Obtain the metadata for Shakespeare plays

shake_metadata <- gutenberg_works(author == "Shakespeare, William") %>%
  filter(gutenberg_id >= 1500 & gutenberg_id <= 1541 & gutenberg_id != 1505 & gutenberg_id != 1525)

# Download plays

shake_plays <- gutenberg_download(shake_metadata$gutenberg_id, meta_fields = "title") # 181,648 rows

# Remove blank lines, characters and stage directions

shake_plays <- shake_plays %>% 
  group_by(gutenberg_id) %>% 
  filter(row_number() > which(text == "ACT I." | text == "ACT 1." |
                                text == "ACT 1" | text == "Act 1." |
                                text == "ACT FIRST"| text == "ACT FIRST." |
                                text == "ACT I" | text == "Act I.")) %>% 
  ungroup()


shake_plays <- shake_plays %>%
  filter(text != "") %>%
  filter(substr(text, 1, 1) != "[") %>%
  filter(!grepl("[A-Z]{2,}", text)) %>%
  filter(!grepl("^[a-zA-Z]+\\.$", text))



