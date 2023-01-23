library(tidyverse)
library(dplyr)

og = read_tsv("Orthogroups/Orthogroups.tsv",col_names=TRUE) %>% rename(CF165 = Fusarium_oxysporum_CF165.proteins,
                                                                       CF159 = Fusarium_oxysporum_CF159.proteins,
                                                                       CF132 = Fusarium_oxysporum_CF132.proteins)
og_counts = read_tsv("Orthogroups/Orthogroups.GeneCount.tsv",col_names=TRUE)
unassigned = read_tsv("Orthogroups/Orthogroups_UnassignedGenes.tsv",col_names=TRUE) %>% 
    rename(CF165 = Fusarium_oxysporum_CF165.proteins,
            CF159 = Fusarium_oxysporum_CF159.proteins,
            CF132 = Fusarium_oxysporum_CF132.proteins)

CF132_only <- og_counts %>% filter(Fusarium_oxysporum_CF132.proteins == Total) %>% select (Orthogroup) %>%
    left_join(og,by="Orthogroup") %>% # get the gene names from the orthogroup table
    select(Orthogroup,CF132) %>% mutate(gene = str_split(CF132, ", ")) %>% unnest(gene) %>% select(Orthogroup,gene)
CF132 <- bind_rows(CF132_only,unassigned %>% select(Orthogroup,CF132) %>% drop_na() %>% rename(gene=CF132))


CF159_only <- og_counts %>% filter(Fusarium_oxysporum_CF159.proteins == Total) %>% select (Orthogroup) %>%
    left_join(og,by="Orthogroup") %>% # get the gene names from the orthogroup table
    select(Orthogroup,CF159) %>% mutate(gene = str_split(CF159, ", ")) %>% unnest(gene) %>% select(Orthogroup,gene)
CF159 <- bind_rows(CF159_only,unassigned %>% select(Orthogroup,CF159) %>% drop_na() %>% rename(gene=CF159))

CF165_only <- og_counts %>% filter(Fusarium_oxysporum_CF165.proteins == Total) %>% select (Orthogroup) %>%
    left_join(og,by="Orthogroup") %>% # get the gene names from the orthogroup table
    select(Orthogroup,CF165) %>% mutate(gene = str_split(CF165, ", ")) %>% unnest(gene) %>% select(Orthogroup,gene)
CF165 <- bind_rows(CF165_only,unassigned %>% select(Orthogroup,CF165) %>% drop_na() %>% rename(gene=CF165))

