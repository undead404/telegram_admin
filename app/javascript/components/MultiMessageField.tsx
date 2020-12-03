import forEach from 'lodash/forEach';
import get from 'lodash/get';
import isEmpty from 'lodash/isEmpty';
import last from 'lodash/last';
import map from 'lodash/map';
import nth from 'lodash/nth';
import without from 'lodash/without';
import React, { useCallback, useEffect, useState } from 'react';
import MultiMessageTextarea from './MultiMessageTextarea';

const MAX_CAPTION_LENGTH = 1024;
const MAX_TEXT_MESSAGE_LENGTH = 4096;
const BEFORE_LAST_INDEX = -2;

export default function MultiMessageField({
  attributeName,
  paragraphs: initialParagraphs,
}: {
  attributeName: string;
  paragraphs: string[];
}): JSX.Element {
  const [paragraphs, setParagraphs] = useState(initialParagraphs);
  const [isImagePresent, setIsImagePresent] = useState(false);
  const dropExtraEmpty = useCallback(() => {
    setParagraphs((paragraphsItems) => [...without(paragraphsItems, ''), '']);
  }, []);
  const handleImageChange: EventListener = useCallback((event) => {
    setIsImagePresent(!isEmpty(get(event.target, 'files')));
  }, []);
  useEffect(() => {
    forEach(document.querySelectorAll('.form.message'), (form) => {
      const imageInput = form.querySelector<HTMLInputElement>('#message_image');
      if (!isEmpty(imageInput.files)) {
        setIsImagePresent(true);
      }
      imageInput.addEventListener('change', handleImageChange);
    });
    return () => {
      forEach(
        document.querySelectorAll('.form.message #message_image'),
        (imageInput) =>
          imageInput.removeEventListener('change', handleImageChange),
      );
    };
  });
  useEffect(() => {
    if (last(paragraphs) === '' && nth(paragraphs, BEFORE_LAST_INDEX) !== '') {
      return;
    }
    dropExtraEmpty();
  }, [dropExtraEmpty, paragraphs]);
  const handleChange = useCallback((newValue: string, index: number) => {
    setParagraphs((paragraphsItems) => {
      if (newValue === paragraphsItems[index]) {
        return paragraphsItems;
      }
      const newParagraphs = Array.from(paragraphsItems);
      newParagraphs[index] = newValue;
      return newParagraphs;
    });
  }, []);
  return (
    <>
      <div className="field-unit__label">
        <label htmlFor={`${attributeName}-1`}>{attributeName}</label>
      </div>
      <div className="field-unit__field multi-message">
        {map(paragraphs, (paragraph, index) => (
          <MultiMessageTextarea
            attributeName={attributeName}
            i={index}
            key={index}
            maxLength={
              isImagePresent && index === 0
                ? MAX_CAPTION_LENGTH
                : MAX_TEXT_MESSAGE_LENGTH
            }
            onBlur={dropExtraEmpty}
            onChange={handleChange}
            value={paragraph}
          />
        ))}
      </div>
    </>
  );
}
