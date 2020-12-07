import forEach from 'lodash/forEach';
import get from 'lodash/get';
import isEmpty from 'lodash/isEmpty';
import last from 'lodash/last';
import map from 'lodash/map';
import nth from 'lodash/nth';
import without from 'lodash/without';
import { parse } from 'query-string';
import React, { useCallback, useEffect, useMemo, useState } from 'react';
import MultiMessageTextarea from './MultiMessageTextarea';

const MAX_CAPTION_LENGTH = 1024;
const MAX_TEXT_MESSAGE_LENGTH = 4096;
const BEFORE_LAST_INDEX = -2;

const YOUTU_BE_REGEXP = /https:\/\/youtu\.be\/([^\s/]+)/;
const YOUTUBE_WATCH_REGEXP = /https:\/\/www.youtube.com\/watch\?([^\s/]+)/;

function useLogChanges<T>(where: string, what: string, value: T) {
  useEffect(() => {
    console.info(where, what, value);
  }, [value, what, where]);
}

function getYoutubeId(text: string): string {
  const youtuBeMatch = YOUTU_BE_REGEXP.exec(text);
  if (youtuBeMatch) {
    return youtuBeMatch[1];
  }
  const youtubeWatchMatch = YOUTUBE_WATCH_REGEXP.exec(text);
  if (youtubeWatchMatch) {
    return parse(youtubeWatchMatch[1]).v as string;
  }
  return '';
}

export default function MultiMessageField({
  attributeName,
  paragraphs: initialParagraphs,
}: {
  attributeName: string;
  paragraphs: string[];
}): JSX.Element {
  const [paragraphs, setParagraphs] = useState(initialParagraphs);
  useLogChanges('MultiMessageField', 'paragraphs', paragraphs);
  const [isImagePresent, setIsImagePresent] = useState(false);
  useLogChanges('MultiMessage', 'isImagePresent', isImagePresent);
  const dropExtraEmpty = useCallback(() => {
    setParagraphs((paragraphsItems) => {
      if (nth(paragraphsItems, BEFORE_LAST_INDEX) !== '') {
        return paragraphsItems;
      }
      return [...without(paragraphsItems, ''), ''];
    });
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
  const youtubePreviewSource = useMemo(() => {
    let youtubeId = '';
    forEach(paragraphs, (paragraph) => {
      youtubeId = getYoutubeId(paragraph);
      return !youtubeId;
    });
    if (!youtubeId) {
      return '';
    }
    return `https://img.youtube.com/vi/${youtubeId}/0.jpg`;
  }, [paragraphs]);
  useLogChanges(
    'MultiMessageField',
    'youtubePreviewSource',
    youtubePreviewSource,
  );
  useEffect(() => {
    if (isImagePresent) {
      return;
    }
    const messageImagePreview: HTMLImageElement = document.querySelector(
      '.image-field img',
    );
    if (messageImagePreview) {
      if (youtubePreviewSource) {
        messageImagePreview.src = youtubePreviewSource;
      } else {
        messageImagePreview.src = '/no_image.png';
      }
    }
  }, [isImagePresent, youtubePreviewSource]);
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
