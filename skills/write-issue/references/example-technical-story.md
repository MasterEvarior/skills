# Technical Story:  Improve Matching

Source: https://github.com/puzzle/pcts/issues/875

## Description
Currently the matching is done using only the Levenshtein algorithm, which can lead to error prone results. Especially if the strings that are compared have wildly differing lengths.

### Current Implementation

```java
// Example usage
private Long mapCertificateTypeId(String name) {
        List<CertificateTypeDto> dtos = this.certificateTypeService.getCertificateTypes();

        return dtos
                .stream()
                .min(Comparator.comparingInt(dto -> calculateDistance(dto.getName(), name)))
                .map(CertificateTypeDto::getId)
                .orElseThrow();
}

// Current implementation    
public Integer calculateDistance(String dtoName, String name) {
        Integer distance = this.levenshtein.apply(dtoName, name);
        logger.info("Input name: {}, Actual name: {}, Distance: {}", name, dtoName, distance);

        return distance;
}
```

### Ideal Changes
The following are ideas to improve the matching. They are sorted in descending order by "how good of an idea is this".

- **Length Pre-Filtering:** before applying the algorithm, remove every options that has a larger than 40% length difference
- **Identical Distances:** Throw an error if multiple distances are the exact same, as we cannot know which one is better.
-  **Normalization:** normalize case and diacritics (e.g. ä to a) before comparing, so that casing and umlaut differences don't count towards the distance
- **Confidence Logging:** log or flag matches where the winning distance is only slightly better than the runner-up, so borderline picks are visible for review 
- **Ensemble Scoring:** combine the Levenshtein distance with a prefix-aware metric like Jaro-Winkler, since Levenshtein alone underweights prefix/abbreviation-style matches
- **AI-Decision:** if two or more results have the same distance, as the LLM to decide which one is better


## Acceptance Criteria
- [x] Some of the improvements have been implemented, tested and confirmed
- [x] New tests are written
- [x] A followup ticket with the ideas left or further ideas is written
- [ ] All DoD items are OK (check the whiteboard)

## Additional Information
- Originally described in #852
