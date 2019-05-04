module Types where

import           Protolude                      ( Eq
                                                , Show
                                                , Generic
                                                )

import           Data.UUID                      ( UUID )
import           Control.Lens
import           Data.ByteString                ( ByteString )
import           Data.Aeson
import           Data.Text                      ( Text )
import           Data.Time.Clock                ( UTCTime )
import           Control.Concurrent.STM         ( TVar )
import           Crypto.Random.DRBG             ( HashDRBG
                                                , GenAutoReseed
                                                )

declareClassy [d|
  newtype Username = Username { usernameText :: Text }
    deriving (Eq, Show, Generic, ToJSON, FromJSON)
  newtype Base64Content = Base64Content { base64ContentText :: Text }
    deriving (Eq, Show, Generic, ToJSON, FromJSON)

  newtype RawPassword = RawPassword { rawPasswordText :: Text }
    deriving (Eq, Show, Generic, ToJSON, FromJSON)

  newtype PublicKey = PublicKey { publicKeyBase64Content :: Base64Content }
    deriving (Eq, Show, Generic, ToJSON, FromJSON)

  newtype CreatedAt = CreatedAt { createdAtUTCTime :: UTCTime }
    deriving (Eq, Show, Generic, ToJSON, FromJSON)

  newtype LastUpdated = LastUpdated { lastUpdatedUTCTime :: UTCTime }
    deriving (Eq, Show, Generic, ToJSON, FromJSON)

  newtype EncryptedMessage = EncryptedMessage
    { encryptedMessageText :: Text }
    deriving (Eq, Show, Generic, ToJSON, FromJSON)

  newtype TitleCiphertext = TitleCiphertext { titleCiphertextEncryptedMessage :: EncryptedMessage }
    deriving (Eq, Show, Generic, ToJSON, FromJSON)

  newtype BodyCiphertext = BodyCiphertext { bodyCiphertextEncryptedMessage :: EncryptedMessage }
    deriving (Eq, Show, Generic, ToJSON, FromJSON)

  newtype UserId = UserId { userIdUUID :: UUID }
      deriving (Eq, Show, Generic, ToJSON, FromJSON)

  newtype JournalId = JournalId { journalIdUUID :: UUID }
      deriving (Eq, Show, Generic, ToJSON, FromJSON)

  newtype HashedPassword = HashedPassword { hashedPasswordText :: Text }
    deriving (Eq, Generic, Show)

  newtype SigningKey = SigningKey { signingKeyByteString :: ByteString }
    deriving (Eq, Show)

  newtype PasswordSalt = PasswordSalt { passwordSaltByteString :: ByteString }

  data AppState = AppState
    { appStateCryptoRandomGen :: TVar (GenAutoReseed HashDRBG HashDRBG)
    , appStateSigningKey :: SigningKey
    }
    deriving (Generic)
 |]
