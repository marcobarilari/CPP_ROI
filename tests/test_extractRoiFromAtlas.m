% (C) Copyright 2020 CPP ROI developers

function test_suite = test_extractRoiFromAtlas() %#ok<*STOUT>
  try % assignment of 'localfunctions' is necessary in Matlab >= 2016
    test_functions = localfunctions(); %#ok<*NASGU>
  catch % no problem; early Matlab versions can use initTestSuite fine
  end
  initTestSuite;
end

function test_extractRoiFromAtlas_wang()

  roiImage = extractRoiFromAtlas(pwd, 'wang', 'V1v', 'L');

  assertEqual(exist(fullfile(pwd, 'space-MNI_hemi-L_label-V1v_desc-wang_mask.nii'), ...
                    'file'), ...
              2);

  vol =  spm_read_vols(spm_vol(roiImage));
  assertEqual(sum(vol(:) == 1), 3605); % check the ROI has the right number of voxel

  delete(fullfile(pwd, '*.nii'));
  delete(fullfile(pwd, '*.json'));

end

function test_extractRoiFromAtlas_neuromorphometrics()

  roiImage = extractRoiFromAtlas(pwd, 'neuromorphometrics', 'Amygdala', 'L');

  assertEqual(exist(fullfile(pwd, ...
                             'space-MNI_hemi-L_label-Amygdala_desc-neuromorphometrics_mask.nii'), ...
                    'file'), ...
              2);

  vol =  spm_read_vols(spm_vol(roiImage));
  assertEqual(sum(vol(:) == 1), 375); % check the ROI has the right number of voxel

  delete(fullfile(pwd, '*.nii'));
  delete(fullfile(pwd, '*.json'));

end
