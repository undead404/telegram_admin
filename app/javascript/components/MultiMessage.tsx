import forEach from "lodash/forEach";
import isEmpty from "lodash/isEmpty";
import last from "lodash/last";
import map from "lodash/map";
import nth from "lodash/nth";
import without from "lodash/without";
import React, { useCallback, useEffect, useState } from "react";
import MultiMessageTextarea from "./MultiMessageTextarea";

export default function MultiMessage({
  attributeName,
  paragraphs: initialParagraphs,
}: {
  attributeName: string;
  paragraphs: string[];
}): JSX.Element {
  const [paragraphs, setParagraphs] = useState(initialParagraphs);
  const [isImagePresent, setIsImagePresent] = useState(false);
  const dropExtraEmpty = useCallback(() => {
    setParagraphs((paragraphsItems) => [...without(paragraphsItems, ""), ""]);
  }, []);
  useEffect(() => {
    forEach(document.querySelectorAll(".form.message"), (form) => {
      const imageInput = form.querySelector<HTMLInputElement>("#message_image");
      if (!isEmpty(imageInput.files)) {
        setIsImagePresent(true);
      }
      imageInput.addEventListener("change", function () {
        setIsImagePresent(!isEmpty(this.files));
      });
    });
  });
  useEffect(() => {
    if (last(paragraphs) === "" && nth(paragraphs, -2) !== "") {
      return;
    }
    dropExtraEmpty();
  }, [dropExtraEmpty, paragraphs]);
  const handleChange = useCallback((newValue: string, i: number) => {
    setParagraphs((paragraphsItems) => {
      if (newValue === paragraphsItems[i]) {
        return paragraphsItems;
      }
      const newParagraphs = [...paragraphsItems];
      newParagraphs[i] = newValue;
      return newParagraphs;
    });
  }, []);
  return (
    <>
      <div className="field-unit__label">
        <label htmlFor={`${attributeName}-1`}>{attributeName}</label>
      </div>
      <div className="field-unit__field multi-message">
        {map(paragraphs, (paragraph, i) => (
          <MultiMessageTextarea
            attributeName={attributeName}
            i={i}
            key={i}
            maxLength={isImagePresent && i === 0 ? 1024 : 4096}
            onBlur={dropExtraEmpty}
            onChange={handleChange}
            value={paragraph}
          />
        ))}
      </div>
    </>
  );
}
