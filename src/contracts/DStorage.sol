pragma solidity ^0.5.0;

contract DStorage {
  string public name = 'DStorage';
  uint public fileCount = 0;
  mapping(uint => File) public files;
  string[] public hashArray = new string[](100);

  struct File {
    uint fileId;
    string fileHash;
    uint fileSize;
    string fileType;
    string fileName;
    string fileDescription;
    uint uploadTime;
    address payable uploader;
  }

  event FileUploaded(
    uint fileId,
    string fileHash,
    uint fileSize,
    string fileType,
    string fileName, 
    string fileDescription,
    uint uploadTime,
    address payable uploader
  );

  constructor() public {
  }

  function uploadFile(string memory _fileHash, uint _fileSize, string memory _fileType, string memory _fileName, string memory _fileDescription) public {
    // string memory _ab = "Qmep96bgCmHYLbg3mDjkmXy2ioovZhf4AsQsS9XhrZ4TVM";

    // require (keccak256(abi. encodePacked(_fileHash)) != keccak256(abi. encodePacked(_ab)) ) ;
    // // Make sure the file hash exists

     for(uint i=1; i<=fileCount; i++){
      string memory _ab = hashArray[i];
      require (keccak256(abi. encodePacked(_fileHash)) != keccak256(abi. encodePacked(_ab)) ) ;
      
    }

    require(bytes(_fileHash).length > 0);
    // Make sure file type exists
    require(bytes(_fileType).length > 0);
    // Make sure file description exists
    require(bytes(_fileDescription).length > 0);
    // Make sure file fileName exists
    require(bytes(_fileName).length > 0);
    // Make sure uploader address exists
    require(msg.sender!=address(0));
    // Make sure file size is more than 0
    require(_fileSize>0);

    // Increment file id
    fileCount ++;

    // Add File to the contract
    files[fileCount] = File(fileCount, _fileHash, _fileSize, _fileType, _fileName, _fileDescription, now, msg.sender);
    hashArray[fileCount]=_fileHash;
    // Trigger an event
    emit FileUploaded(fileCount, _fileHash, _fileSize, _fileType, _fileName, _fileDescription, now, msg.sender);
  }
}