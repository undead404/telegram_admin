import head from 'lodash/head';
import React, { ChangeEvent, useCallback, useState } from 'react';

export default function ImageField({
  attributeName,
  entityName,
  value,
}: {
  attributeName: string;
  entityName: string;
  value: string;
}): JSX.Element {
  const [fileUrl, setFileUrl] = useState<string | null>(value || null);
  const handleChange = useCallback((event: ChangeEvent<HTMLInputElement>) => {
    const file = head(event.target.files);
    if (!file) {
      setFileUrl(null);
    } else {
      setFileUrl(URL.createObjectURL(file));
    }
  }, []);
  const id = `${entityName}_${attributeName}`;
  return (
    <>
      <div className="field-unit__label">
        <label htmlFor={id}>Image</label>
      </div>
      <div className="field-unit__field image-field">
        <img alt="Empty" src={fileUrl || '/no_image.png'} />
        <input
          id={id}
          name={`${entityName}[${attributeName}]`}
          onChange={handleChange}
          type="file"
        />
      </div>
    </>
  );
}
